package matching_brackets

import "core:testing"

@(test)
/// description = paired square brackets
test_paired_square_brackets :: proc(t: ^testing.T) {
	input := "[]"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
/// description = empty string
test_empty_string :: proc(t: ^testing.T) {
	input := ""
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
/// description = unpaired brackets
test_unpaired_brackets :: proc(t: ^testing.T) {
	input := "[["
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = wrong ordered brackets
test_wrong_ordered_brackets :: proc(t: ^testing.T) {
	input := "}{"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = wrong closing bracket
test_wrong_closing_bracket :: proc(t: ^testing.T) {
	input := "{]"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = paired with whitespace
test_paired_with_whitespace :: proc(t: ^testing.T) {
	input := "{ }"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
/// description = partially paired brackets
test_partially_paired_brackets :: proc(t: ^testing.T) {
	input := "{[])"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = simple nested brackets
test_simple_nested_brackets :: proc(t: ^testing.T) {
	input := "{[]}"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
/// description = several paired brackets
test_several_paired_brackets :: proc(t: ^testing.T) {
	input := "{}[]"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
/// description = paired and nested brackets
test_paired_and_nested_brackets :: proc(t: ^testing.T) {
	input := "([{}({}[])])"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
/// description = unopened closing brackets
test_unopened_closing_brackets :: proc(t: ^testing.T) {
	input := "{[)][]}"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = unpaired and nested brackets
test_unpaired_and_nested_brackets :: proc(t: ^testing.T) {
	input := "([{])"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = paired and wrong nested brackets
test_paired_and_wrong_nested_brackets :: proc(t: ^testing.T) {
	input := "[({]})"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = paired and wrong nested brackets but innermost are correct
test_paired_and_wrong_nested_brackets_but_innermost_are_correct :: proc(t: ^testing.T) {
	input := "[({}])"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = paired and incomplete brackets
test_paired_and_incomplete_brackets :: proc(t: ^testing.T) {
	input := "{}["
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = too many closing brackets
test_too_many_closing_brackets :: proc(t: ^testing.T) {
	input := "[]]"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = early unexpected closing bracket
test_early_unexpected_closing_bracket :: proc(t: ^testing.T) {
	input := ")()"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = early mismatched brackets
test_early_mismatched_brackets :: proc(t: ^testing.T) {
	input := "{)()"
	testing.expect_value(t, is_balanced(input), false)
}

@(test)
/// description = math expression
test_math_expression :: proc(t: ^testing.T) {
	input := "(((185 + 223.85) * 15) - 543)/2"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
/// description = complex latex expression
test_complex_latex_expression :: proc(t: ^testing.T) {
	input := "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)"
	testing.expect_value(t, is_balanced(input), true)
}

@(test)
/// description = maximum nesting expression
test_maximum_nesting_expression :: proc(t: ^testing.T) {
	input := "(((_[[[_{{{_()_}}}_]]]_)))"
	testing.expect_value(t, is_balanced(input), true)
}
