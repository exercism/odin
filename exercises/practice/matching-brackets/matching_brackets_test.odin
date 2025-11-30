package matching_brackets

import "core:testing"

@(test)
test_paired_square_brackets :: proc(t: ^testing.T) {
	input := "[]"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
test_empty_string :: proc(t: ^testing.T) {
	input := ""
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
test_unpaired_brackets :: proc(t: ^testing.T) {
	input := "[["
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_wrong_ordered_brackets :: proc(t: ^testing.T) {
	input := "}{"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_wrong_closing_bracket :: proc(t: ^testing.T) {
	input := "{]"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_paired_with_whitespace :: proc(t: ^testing.T) {
	input := "{ }"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
test_partially_paired_brackets :: proc(t: ^testing.T) {
	input := "{[])"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_simple_nested_brackets :: proc(t: ^testing.T) {
	input := "{[]}"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
test_several_paired_brackets :: proc(t: ^testing.T) {
	input := "{}[]"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
test_paired_and_nested_brackets :: proc(t: ^testing.T) {
	input := "([{}({}[])])"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
test_unopened_closing_brackets :: proc(t: ^testing.T) {
	input := "{[)][]}"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_unpaired_and_nested_brackets :: proc(t: ^testing.T) {
	input := "([{])"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_paired_wrong_nested :: proc(t: ^testing.T) {
	input := "[({]})"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_paired_wrong_nested_innermost_correct :: proc(t: ^testing.T) {
	input := "[({}])"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_paired_incomplete :: proc(t: ^testing.T) {
	input := "{}["
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_too_many_closing :: proc(t: ^testing.T) {
	input := "[]]"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_early_unexpected :: proc(t: ^testing.T) {
	input := ")()"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_early_mismatched :: proc(t: ^testing.T) {
	input := "{)()"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
test_math_expression :: proc(t: ^testing.T) {
	input := "(((185 + 223.85) * 15) - 543)/2"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
test_complex_latex :: proc(t: ^testing.T) {
	input := "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
test_maximum_nesting :: proc(t: ^testing.T) {
	input := "(((_[[[_{{{_()_}}}_]]]_)))"
	testing.expect_value(t, is_balanced(input), true)
}
