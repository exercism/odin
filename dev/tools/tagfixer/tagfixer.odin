package tagfixer

import "core:encoding/json"
import "core:fmt"
import "core:os"
import "core:strings"
import "core:text/regex"

main :: proc() {

	// This program will run once and exit so
	// there is no need to release memory manually, let the OS do it.

	// We can get the test metadata (description, uuid, reimplements)
	// from either its canonical data or the `.meta/tests.toml` file.

	// For canonical data, Odin returns the JSON blob as a tree of
	// `json.Value` and we cast it to the correct type based on the schema.
	// If the canonical data file doesn't follow the schema we
	// will get a casting error and that's okay.

	if len(os.args) != 4 {
		fmt.eprintln("Usage: tagfixer <testfile_path> <meta_data_path> <updated_testfile_path>")
		os.exit(1)
	}

	test_path := os.args[1]
	metadata_path := os.args[2]
	output_path := os.args[3]

	// test_path := "example/rational_numbers_test.odin"
	// metadata_path := "example/tests.toml"
	// output_path := "example/updated_rational_numbers_test.odin"

	test_src, test_ok := os.read_entire_file_from_filename(test_path)
	if !test_ok {
		fmt.eprintf("Unable to open test file %s\n", test_path)
		os.exit(1)
	}

	// We can read the tests metadata from the `canonical-data.json`` or the `tests.toml`` file.
	// We don't need both methods for now but, since we have the code, let's allow both methods
	// in case there are additional informations needed later.
	read_metadata: proc(path: string) -> (Snake_English_Map, Error)
	switch {
	case strings.ends_with(metadata_path, ".json"):
		read_metadata = read_canonical_data
	case strings.ends_with(metadata_path, ".toml"):
		read_metadata = read_toml_data
	case:
		fmt.eprintf("Expected metadata to be a .json or a .toml file but got%s\n", metadata_path)
		os.exit(1)
	}
	snk_to_eng, err := read_metadata(metadata_path)
	switch err in err {
	case string:
		fmt.eprintln(err)
		os.exit(1)
	}

	outfile, out_err := os.open(output_path, os.O_RDWR | os.O_CREATE | os.O_TRUNC, 0o644)
	if out_err != nil {
		fmt.eprintf("Unable to open output file %s\n", output_path)
		os.exit(1)
	}
	report := add_descriptions_to_tests(string(test_src), snk_to_eng, outfile)

	// Report which tests were found in canonical data or were present (report[test] == true)
	// and for which tests we had to make up a name (report[test] == false).
	// We may hide this being a `--verbose` flag later.
	need_header := true
	for entry in report {
		if entry.source == .CData { continue }
		if need_header {
			fmt.printf("\nWarnings:\n")
			fmt.printf("=========\n\n")
			need_header = false
		}
		fmt.printf("- test_%s:\n", entry.proc_name)
		source := "Already in file" if entry.source == .Original else "Rebuilt from proc. name"
		fmt.printf("  => %s:'%s'\n\n", source, entry.eng_name)
	}
}

Error :: union {
	string,
}

Snake_English_Map :: map[string]string

Scan_State :: enum {
	Ouside,
	Found_Test_Attribute,
	Found_Description,
	Found_Task,
	Found_Test_Signature,
}

Desc_Source :: enum {
	CData,
	Rebuilt,
	Original,
}

Report :: struct {
	proc_name: string,
	eng_name:  string,
	source:    Desc_Source,
}

// Returns a list of test names that we found with a report flag:
// - true: the test English description was found in the canonical data or was present
// - false: the test description was not found and it reverted to `rebuild_english()`
add_descriptions_to_tests :: proc(
	test_src: string,
	snk_to_eng: Snake_English_Map,
	out: os.Handle,
) -> []Report {

	report: [dynamic]Report
	state: Scan_State
	proc_name: string
	desc_line: string
	task_line: string
	sign_line: string
	comment_lines: [dynamic]string
	// I found a couple of tests that didn't start with 'test_', accounting for that.
	proc_re, re_err := regex.create(`(test_)?([a-zA-Z0-9_]+)\s*::\s*proc`)
	ensure(re_err == nil)
	capture := regex.preallocate_capture()

	for line in strings.split(string(test_src), "\n") {
		switch state {
		case .Ouside:
			if strings.starts_with(line, "@(test)") {
				state = .Found_Test_Attribute
				desc_line = ""
				task_line = ""
				sign_line = ""
				proc_name = ""
				clear(&comment_lines)
			} else {
				fmt.fprintln(out, line)
			}
		case .Found_Test_Attribute:
			// There could already be a description populated.
			// We are assuming there would not be a task without a description.
			if strings.starts_with(line, "/// description = ") {
				state = .Found_Description
				desc_line = line
			} else if ng, ok := regex.match(proc_re, line, &capture); ok {
				state = .Found_Test_Signature
				sign_line = line
				proc_name = capture.groups[ng - 1]
			} else {
				// There may be comment lines, keep them
				// we will move them before @(test)
				append(&comment_lines, line)
			}
		case .Found_Description:
			if strings.starts_with(line, "/// task_id = ") {
				state = .Found_Task
				task_line = line
			} else if ng, ok := regex.match(proc_re, line, &capture); ok {
				state = .Found_Test_Signature
				sign_line = line
				proc_name = capture.groups[ng - 1]
			} else {
				// There may be comment lines, keep them
				// we will move them before @(test)
				append(&comment_lines, line)
			}
		case .Found_Task:
			if ng, ok := regex.match(proc_re, line, &capture); ok {
				state = .Found_Test_Signature
				sign_line = line
				proc_name = capture.groups[ng - 1]
			} else {
				// There may be comment lines, keep them
				// we will move them before @(test)
				append(&comment_lines, line)
			}
		case .Found_Test_Signature:
			// We are writing out
			//   comment lines (if any)
			//   @(test)
			//   /// description = ...
			//   // task_id = ... (only if we found a task line)
			//   // procedure signature line
			for comment in comment_lines {
				fmt.fprintln(out, comment)
			}
			fmt.fprintln(out, "@(test)")
			// trimmed_proc_name := rm_prefix(proc_name, "test_")
			//fmt.printf(">lookup>/%s/\n", trimmed_proc_name)
			if len(desc_line) > 0 {
				desc_eng := rm_prefix(desc_line, "/// description = ")
				append(
					&report,
					Report{proc_name = proc_name, eng_name = desc_eng, source = .Original},
				)
				fmt.fprintln(out, desc_line)
			} else {
				desc_eng, ok := snk_to_eng[proc_name]
				if !ok {
					desc_eng = rebuild_english(proc_name)
					append(
						&report,
						Report{proc_name = proc_name, eng_name = desc_eng, source = .Rebuilt},
					)
					//fmt.printf(">>rebuild>>/%s/%s/\n", proc_name, desc_eng)
				} else {
					append(
						&report,
						Report{proc_name = proc_name, eng_name = desc_eng, source = .CData},
					)
				}
				fmt.fprintf(out, "/// description = %s\n", desc_eng)
			}
			if len(task_line) > 0 {
				fmt.fprintln(out, task_line)
			}
			fmt.fprintln(out, sign_line)
			fmt.fprintln(out, line)
			state = .Ouside
		}
	}
	return report[:]
}

to_snake_case :: proc(english: string) -> string {

	// There is no procedure to replace portion of a string
	// based on a regex in Odin so we have to do this the hard way.
	//
	// Actually Odin has `strings.to_snake_case()`, I will have
	// to test to see if it is compatible with the bash version.

	// Nested case descriptions are separated by " -> ", let fix this first.
	nst_english, _ := strings.replace_all(english, " -> ", "__")
	buf := strings.builder_make()
	prev: rune
	for char in nst_english {
		switch {
		case 'A' <= char && char <= 'Z':
			if '0' <= prev && prev <= '9' || 'a' <= prev && prev <= 'z' {
				// Camel Case, convert it to snake case
				strings.write_rune(&buf, '_')
			}
			strings.write_rune(&buf, char)
		case char == ' ' || char == '-' || char == '_':
			strings.write_rune(&buf, '_')
		case '0' <= char && char <= '9':
			strings.write_rune(&buf, char)
		case 'a' <= char && char <= 'z':
			strings.write_rune(&buf, char)
		case 'a' <= char && char <= 'z':
			strings.write_rune(&buf, char)
		case:
		// Ignore non alphanumeric characters
		}
		prev = char
	}
	snake_case := strings.to_lower(strings.to_string(buf))
	return snake_case
}

rebuild_english :: proc(snake: string) -> string {

	if len(snake) == 0 { return "" }
	if len(snake) == 1 { return strings.to_upper(snake) }

	snake_no_test := snake
	if strings.starts_with(snake_no_test, "test_") {
		snake_no_test, _ = strings.substring_from(snake_no_test, 5)
	}

	// Caution with nested test cases: each level is separated with
	// 2 underscores. When going back we separate the level (in english)
	// with ": ".
	buf := strings.builder_make()
	first := true
	for snk_level in strings.split(snake_no_test, "__") {
		lc_eng_level, _ := strings.replace_all(snk_level, "_", " ")
		english_level := capitalize(lc_eng_level)
		if first {
			first = false
		} else {
			strings.write_string(&buf, " -> ")
		}
		strings.write_string(&buf, english_level)
	}
	return strings.to_string(buf)
}

capitalize :: proc(s: string) -> string {

	if len(s) == 0 { return "" }
	if len(s) == 1 { return strings.to_upper(s) }
	first_letter, _ := strings.substring(s, 0, 1)
	other_letters, _ := strings.substring_from(s, 1)
	return strings.concatenate({strings.to_upper(first_letter), other_letters})

}

rm_prefix :: proc(s: string, prefix: string) -> string {

	if strings.starts_with(s, prefix) {
		trimmed_str, _ := strings.substring_from(s, len(prefix))
		return trimmed_str
	}
	return s
}

add_prefix :: proc(s: string, prefix: string) -> string {

	return strings.concatenate([]string{prefix, s})
}

read_toml_data :: proc(tests_toml_path: string) -> (Snake_English_Map, Error) {

	TomlData :: struct {
		uuid:         string,
		desc:         string,
		not_include:  bool,
		reimplements: string,
	}

	// Read the tests meta data from the tests.toml file.
	// We are reading too much for now but let's keep it in case we need more
	// data later.
	tdata, tdata_ok := os.read_entire_file_from_filename(tests_toml_path)
	if !tdata_ok {
		return nil, fmt.aprintf("Unable to open file %s\n", tests_toml_path)
	}

	uuid_re, re_err := regex.create(`\[([a-f0-9]+-[a-f0-9]+-[a-f0-9]+-[a-f0-9]+-[a-f0-9]+)\]`)
	capture := regex.preallocate_capture()
	ensure(re_err == nil)
	tests: [dynamic]TomlData
	in_entry: bool
	entry := TomlData{}

	lineno := 0
	for line in strings.split(string(tdata), "\n") {
		lineno += 1
		if in_entry {
			switch {
			case len(line) == 0:
				in_entry = false
				append(&tests, entry)
				entry = TomlData{}
			case strings.starts_with(line, "description = "):
				desc, _ := strings.substring(line, 15, len(line) - 1)
				entry.desc = desc
			case strings.starts_with(line, "include = "):
				include_as_str, _ := strings.substring(line, 10, len(line))
				switch include_as_str {
				case "true":
					entry.not_include = false
				case "false":
					entry.not_include = true
				case:
					return nil, fmt.aprintf(
						"Invalid value for include '%s' on line %d",
						include_as_str,
						lineno,
					)
				}
			case strings.starts_with(line, "reimplements = "):
				uuid, _ := strings.substring(line, 16, len(line) - 1)
				entry.reimplements = uuid
			}
		} else {
			_, success := regex.match(uuid_re, line, &capture)
			if success {
				in_entry = true
				//fmt.printf(">%d>%#v\n", ng, capture)
				entry.uuid = capture.groups[1]
			}

		}
	}

	snk_to_eng: Snake_English_Map
	for test in tests {
		if !test.not_include {
			test_desc_eng := test.desc
			test_desc_snk := to_snake_case(test_desc_eng)
			snk_to_eng[test_desc_snk] = test_desc_eng
			//fmt.printf(">>map>>/%s/%s/\n", test_desc_snk, test_desc_eng)
		}
	}

	return snk_to_eng, nil
}

read_canonical_data :: proc(cdata_path: string) -> (Snake_English_Map, Error) {

	// Read the JSON data out of the canonical data file.
	cdata, cdata_ok := os.read_entire_file_from_filename(cdata_path)
	if !cdata_ok {
		return nil, fmt.aprintf("Unable to open canonical data file %s\n", cdata_path)
	}

	json_data, json_err := json.parse(cdata)
	if json_err != .None {
		return nil, fmt.aprintf("Failed to parse the canonical data as json: %v\n", json_err)
	}

	// Populate the Snake to English map.
	snk_to_eng: Snake_English_Map
	root_object := json_data.(json.Object)
	cases_array := root_object["cases"].(json.Array)
	populate_test_from_cdata(cases_array, "", "", &snk_to_eng)

	return snk_to_eng, nil
}

populate_test_from_cdata :: proc(
	cases: json.Array,
	prefix_eng: string,
	prefix_snk: string,
	snk_to_eng: ^Snake_English_Map,
) {

	for test in cases {
		test_object := test.(json.Object)
		test_desc_eng := test_object["description"].(string)
		test_desc_snk := to_snake_case(test_desc_eng)
		ext_desc_eng :=
			test_desc_eng if prefix_eng == "" else strings.join({prefix_eng, test_desc_eng}, " -> ")
		ext_desc_snk :=
			test_desc_snk if prefix_snk == "" else strings.join({prefix_snk, test_desc_snk}, "__")
		snk_to_eng[ext_desc_snk] = ext_desc_eng
		//fmt.printf(">>>/%s/%s/\n", ext_desc_snk, ext_desc_eng)
		if test_object["cases"] != nil {
			sub_cases_array := test_object["cases"].(json.Array)
			populate_test_from_cdata(sub_cases_array, ext_desc_eng, ext_desc_snk, snk_to_eng)
		}
	}
}

/*
main :: proc() {

	eng := "Arithmetic -> Multiplication -> Multiply a rational number by 0"
	snk := to_snake_case(eng)
	fmt.printf("/%s/\n", snk)
}
*/
