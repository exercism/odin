package exercism

import "core:fmt"
import "core:strings"

Argument :: struct {
	name:  string,
	type:  string,
	value: any,
}

Function :: struct {
	name: string,
	args: []Argument,
	ret:  Argument,
}

Test :: struct {
	name:     string,
	function: Function,
	expected: any,
	actual:   any,
}

main :: proc() {
	args := []Argument {
		Argument{name = "abc", type = "int", value = 10},
		Argument{name = "xyz", type = "string", value = "foo"},
	}

	function := Function {
		name = "bob",
		args = args,
		ret = Argument{name = "www", type = "string", value = "123"},
	}

	test := Test {
		name     = "should_do_the_thing",
		function = function,
		expected = "123",
	}

	indent_level := 0

	b := strings.builder_make()
	w(&b, indent_level, true, `// main.odin`)
	generate_function(&b, indent_level, function)
	w(&b, indent_level, true, ``)
	w(&b, indent_level, true, `// test.odin`)
	generate_test(&b, indent_level, test)
	w(&b, indent_level, true, ``)

	fmt.printf("{}", strings.to_string(b))
}

generate_function :: proc(b: ^strings.Builder, i: int, function: Function) {
	w(b, i, true, `package exercism`)
	w(b, i, true, ``)
	w(b, i, false, `{} :: proc(`, function.name)

	for arg, index in function.args {
		generate_argument(b, 0, false, arg)

		last_index := len(function.args) - 1
		if index != last_index {
			w(b, 0, false, `, `)
		}
	}

	w(b, i, true, `) -> {{`)
	w(
		b,
		i + 1,
		true,
		`{}: {} = {}`,
		function.ret.name,
		function.ret.type,
		function.ret.value,
	)
	w(b, i + 1, true, `return {}`, function.ret.name)
	w(b, i, true, `}}`)
}

generate_argument :: proc(
	b: ^strings.Builder,
	i: int,
	newline: bool,
	argument: Argument,
) {
	if argument.type == "string" {
		w(
			b,
			i,
			newline,
			`{}: {} = "{}"`,
			argument.name,
			argument.type,
			argument.value,
		)
	} else {
		w(
			b,
			i,
			newline,
			`{}: {} = {}`,
			argument.name,
			argument.type,
			argument.value,
		)
	}
}

generate_test :: proc(b: ^strings.Builder, i: int, test: Test) {
	w(b, i, true, `package exercism`)
	w(b, i, true, ``)
	w(b, i, true, `import "core:testing"`)
	w(b, i, true, ``)
	w(b, i, true, `@(test)`)
	w(b, i, true, `test_{} :: proc(t: ^testing.T) {{`, test.name)
	w(b, i + 1, true, `expected := {}`, test.expected)

	for arg, index in test.function.args {
		generate_argument(b, i + 1, true, arg)
	}

	w(b, i + 1, false, `result := {}(`, test.function.name)

	for arg, index in test.function.args {
		w(b, i, false, `{}`, arg.name)

		last_index := len(test.function.args) - 1
		if index != last_index {
			w(b, 0, false, `, `)
		}
	}

	w(b, 0, true, `)`)
	w(b, i + 1, true, `testing.expect_value(t, result, expected)`)
	w(b, i, true, `)`)
}

// Write
w :: proc(
	b: ^strings.Builder,
	ind := 0,
	newline := true,
	format: string,
	args: ..any,
) {
	indent(b, ind)
	fmt.sbprintf(b, format, ..args)

	if newline {
		fmt.sbprintf(b, "\n")
	}
}

// Generates a number of tab/space characters
indent :: proc(b: ^strings.Builder, ind: int) {
	indent_rune := '\t'
	for i in 0 ..< ind do strings.write_rune(b, indent_rune)
}
