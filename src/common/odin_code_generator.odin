package common

import "core:fmt"
import "core:strings"

Argument :: struct {
	name: string,
  type: string,
	value: any,
}

Function :: struct {
  name: string,
  args: []Argument,
  ret: Argument
}

Test :: struct {
  name: string,
  function: Function,
  expected: any,
  actual: any
}

generate_function :: proc(sb: ^strings.Builder, i: int, function: Function) {
	write_to_sb(sb, i, true, `package exercism`)
	write_to_sb(sb, i, true, ``)
	write_to_sb(sb, i, false, `{} :: proc(`, function.name)

  for arg, index in function.args {
    generate_argument(sb, 0, false, arg)

    last_index := len(function.args) - 1
    if index != last_index {
      write_to_sb(sb, 0, false, `, `)
    }
  }  

	write_to_sb(sb, i, true, `) -> {{`)
	write_to_sb(sb, i+1, true, `{}: {} = {}`, function.ret.name, function.ret.type, function.ret.value)
	write_to_sb(sb, i+1, true, `return {}`, function.ret.name)
	write_to_sb(sb, i, true, `}}`)
}

generate_argument :: proc(sb: ^strings.Builder, i: int, newline: bool, argument: Argument) {
  if argument.type == "string" {
  	write_to_sb(sb, i, newline, `{}: {} = "{}"`, argument.name, argument.type, argument.value)
  } else {
  	write_to_sb(sb, i, newline, `{}: {} = {}`, argument.name, argument.type, argument.value)
  }
}

generate_test :: proc(sb: ^strings.Builder, i: int, test: Test) {
	write_to_sb(sb, i, true, `package exercism`)
	write_to_sb(sb, i, true, ``)
	write_to_sb(sb, i, true, `import "core:testing"`)
	write_to_sb(sb, i, true, ``)
	write_to_sb(sb, i, true, `@(test)`)
	write_to_sb(sb, i, true, `test_{} :: proc(t: ^testing.T) {{`, test.name)
	write_to_sb(sb, i+1, true, `expected := {}`, test.expected)

  for arg, index in test.function.args {
    generate_argument(sb, i+1, true, arg)
  }

	write_to_sb(sb, i+1, false, `result := {}(`, test.function.name)

  for arg, index in test.function.args {
  	write_to_sb(sb, i, false, `{}`, arg.name)

    last_index := len(test.function.args) - 1
    if index != last_index {
      write_to_sb(sb, 0, false, `, `)
    }
  }

	write_to_sb(sb, 0, true, `)`)
	write_to_sb(sb, i+1, true, `testing.expect_value(t, result, expected)`)
	write_to_sb(sb, i, true, `)`)
}

write_to_sb :: proc(sb: ^strings.Builder, ind := 0, newline := true, format: string, args: ..any) {
  write_indents_to_sb(sb, ind)
  fmt.sbprintf(sb, format, ..args)

  if newline {
    fmt.sbprintf(sb, "\n")
  }
}

// Generates a number of tab/space characters
write_indents_to_sb :: proc(sb: ^strings.Builder, ind: int) {
  indent_rune := '\t'
  for i in 0..<ind do strings.write_rune(sb, indent_rune)
}