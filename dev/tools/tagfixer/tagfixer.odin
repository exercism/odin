package tagfixer

import "core:encoding/json"
import "core:fmt"
import "core:os"
import "core:strings"
import "core:text/regex"
import "core:text/regex/common"

main :: proc() {

	// This program will run once and exit so
	// there is no need to release memory manually,
	// let the OS do it.

	// We know the schema of the canonical data.
	// Odin returns the JSON blob as a tree of `json.Value`
	// and we cast it to the correct type based on the schema.
	// If the canonical data file doesn't follow the schema we
	// will get a casting error and that okay.

	if len(os.args) != 3 {
		fmt.eprintln("Usage: tagfixer <testfile_path> <canonical_data_path>")
		os.exit(1)
	}

	test_path := os.args[1]
	cdata_path := os.args[2]

	test_src, test_ok := os.read_entire_file_from_filename(test_path)
	if !test_ok {
		fmt.eprintf("Unable to open test file %s\n", test_path)
		os.exit(1)
	}

	json_data, json_err := read_canonical_data(cdata_path)
	if err, ok := json_err.(string); ok {
		fmt.eprintln(err)
		os.exit(1)
	}

	snk_to_eng: map[string]string
	root_object := json_data.(json.Object)
	cases_array := root_object["cases"].(json.Array)
	populate_test_descriptions(cases_array, "", "", &snk_to_eng)

	add_descriptions_to_tests(string(test_src), snk_to_eng)

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
	// Actually Odin has `strings.o_snake_case()`, I will have
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
		case char == ' ' || char == '-' || char == '_':
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

	english, _ := strings.replace_all(snake, "_", " ")
	first_letter, _ := strings.substring(english, 0, 1)
	other_letter, _ := strings.substring_from(english, 1)
	return strings.concatenate({strings.to_upper(first_letter), other_letter})
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

add_descriptions_to_tests :: proc(test_src: string, snk_to_eng: map[string]string) {

	state: Scan_State
	proc_name: string
	desc_line: string
	task_line: string
	sign_line: string
	comment_lines: [dynamic]string
	proc_re, re_err := regex.create(`test_([a-zA-Z][a-zA-Z0-9_]+)\s*::\s*proc`)
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
				fmt.println(line)
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
				proc_name = capture.groups[1]
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
				proc_name = capture.groups[1]
			} else {
				// There may be comment lines, keep them
				// we will move them before @(test)
				append(&comment_lines, line)
			}
		case .Found_Task:
			if ng, ok := regex.match(proc_re, line, &capture); ok {
				state = .Found_Test_Signature
				sign_line = line
				proc_name = capture.groups[1]
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
				fmt.println(comment)
			}
			fmt.println("@(test)")
			if len(desc_line) > 0 {
				fmt.println(desc_line)
			} else {
				desc_eng, ok := snk_to_eng[proc_name]
				if !ok {
					desc_eng = rebuild_english(proc_name)
				}
				fmt.printf("/// description = %s\n", desc_eng)
			}
			if len(task_line) > 0 {
				fmt.println(task_line)
			}
			fmt.println(sign_line)
			state = .Ouside
		}
	}
}
