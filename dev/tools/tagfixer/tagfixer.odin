package tagfixer

import "core:encoding/json"
import "core:fmt"
import "core:os"
import "core:slice"
import "core:strings"
import "core:text/regex"

main :: proc() {

	// This program will run once and exit so
	// there is no need to release memory manually,
	// let the OS do it.

	// We know the schema of the canonical data.
	// Odin returns the JSON blob as a tree of `json.Value`
	// and we cast it to the correct type based on the schema.
	// If the canonical data file doesn't follow the schema we
	// will get a casting error and that's okay.

	if len(os.args) != 4 {
		fmt.eprintln(
			"Usage: tagfixer <testfile_path> <canonical_data_path> <updated_testfile_path>",
		)
		os.exit(1)
	}

	test_path := os.args[1]
	cdata_path := os.args[2]
	output_path := os.args[3]

	// test_path := "example/rational_numbers_test.odin"
	// cdata_path := "example/canonical-data.json"
	// output_path := "example/updated_rational_numbers_test.odin"

	test_src, test_ok := os.read_entire_file_from_filename(test_path)
	if !test_ok {
		fmt.eprintf("Unable to open test file %s\n", test_path)
		os.exit(1)
	}

	json_data, json_err := read_canonical_data(cdata_path)
	switch err in json_err {
	case string:
		fmt.eprintln(err)
		os.exit(1)
	}

	snk_to_eng: map[string]string
	root_object := json_data.(json.Object)
	cases_array := root_object["cases"].(json.Array)
	populate_test_descriptions(cases_array, "", "", &snk_to_eng)

	outfile, out_err := os.open(output_path, os.O_RDWR | os.O_CREATE | os.O_TRUNC, 0o644)
	if out_err != nil {
		fmt.eprintf("Unable to open output file %s\n", output_path)
		os.exit(1)
	}
	report := add_descriptions_to_tests(string(test_src), snk_to_eng, outfile)

	// Report which tests were found in canonical data or were present (report[test] == true)
	// and for which tests we had to make up a name (report[test] == false).
	// We may hide this being a `--verbose` flag later.
	fmt.println("Tag Report:")
	for entry in report {
		fmt.printf("- %s:\n")
		fmt.printf("      '%v':\n")
		fmt.printf("      '%s':\n")
	}
}

Error :: union {
	string,
}

read_canonical_data :: proc(cdata_path: string) -> (json.Value, Error) {

	cdata, cdata_ok := os.read_entire_file_from_filename(cdata_path)
	if !cdata_ok {
		return nil, fmt.aprintf("Unable to open canonical data file %s\n", cdata_path)
	}

	json_data, json_err := json.parse(cdata)
	if json_err != .None {
		return nil, fmt.aprintf("Failed to parse the canonical data as json: %v\n", json_err)
	}

	return json_data, nil
}

to_snake_case :: proc(english: string) -> string {

	// There is no procedure to replace portion of a string
	// based on a regex in Odin so we have to do this the hard way.
	//
	// Actually Odin has `strings.to_snake_case()`, I will have
	// to test to see if it is compatible with the bash version.

	buf := strings.builder_make()
	prev: rune
	for char in english {
		switch {
		case 'A' <= char && char <= 'Z':
			if '0' <= prev && prev <= '9' || 'a' <= prev && prev <= 'z' {
				// Camel Case, convert it to snake case
				strings.write_rune(&buf, '_')
			}
			strings.write_rune(&buf, char)
		case char == ' ':
			// Special case for nested cases, we separate each level
			// with ": "
			if prev == ':' {
				strings.write_string(&buf, "__")
			} else {
				strings.write_rune(&buf, '_')
			}
		case char == '-' || char == '_':
			strings.write_rune(&buf, '_')
		case '0' < char && char <= '9':
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

	// Caution with nested test cases: each level is separated with
	// 2 underscores. When going back we separate the level (in english)
	// with ": ".
	buf := strings.builder_make()
	first := true
	for snk_level in strings.split(snake, "__") {
		lc_eng_level, _ := strings.replace_all(snk_level, "_", " ")
		english_level := capitalize(lc_eng_level)
		if first {
			first = false
		} else {
			strings.write_string(&buf, ": ")
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

populate_test_descriptions :: proc(
	cases: json.Array,
	prefix_eng: string,
	prefix_snk: string,
	snk_to_eng: ^map[string]string,
) {

	for test in cases {
		test_object := test.(json.Object)
		test_desc_eng := test_object["description"].(string)
		test_desc_snk := to_snake_case(test_desc_eng)
		ext_desc_eng :=
			test_desc_eng if prefix_eng == "" else strings.join({prefix_eng, test_desc_eng}, ": ")
		ext_desc_snk :=
			test_desc_snk if prefix_snk == "" else strings.join({prefix_snk, test_desc_snk}, "__")
		snk_to_eng[ext_desc_snk] = ext_desc_eng
		if test_object["cases"] != nil {
			sub_cases_array := test_object["cases"].(json.Array)
			populate_test_descriptions(sub_cases_array, ext_desc_eng, ext_desc_snk, snk_to_eng)
		}
	}
}

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
	In_Original,
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
	snk_to_eng: map[string]string,
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
	proc_re, re_err := regex.create(`(test_)?([a-zA-Z][a-zA-Z0-9_]+)\s*::\s*proc`)
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
			if len(desc_line) > 0 {
				desc_eng := remove_tag(desc_line)
				append(
					&report,
					Report{proc_name = proc_name, eng_name = desc_eng, source = .In_Original},
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

remove_tag :: proc(s: string) -> string {

	idx := strings.index(s, "escription =")
	if idx < 0 {
		return s
	}
	desc, _ := strings.substring_from(s, idx + 12)
	return desc
}
