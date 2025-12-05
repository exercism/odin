package forth

import "core:fmt"
import "core:testing"

expect_slices_match :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {
	result := fmt.aprintf("%v", actual)
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str, loc = loc)
}

@(test)
test_parsing_and_numbers__numbers_just_get_pushed_onto_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 3 4 5")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 2, 3, 4, 5})
}

@(test)
test_parsing_and_numbers__pushes_negative_numbers_onto_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("-1 -2 -3 -4 -5")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{-1, -2, -3, -4, -5})
}

@(test)
test_addition__can_add_two_numbers :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 +")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{3})
}

@(test)
test_addition__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("+")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_addition__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 +")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_addition__more_than_two_values_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 3 +")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 5})
}

@(test)
test_subtraction__can_subtract_two_numbers :: proc(t: ^testing.T) {

	result, error := evaluate("3 4 -")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{-1})
}

@(test)
test_subtraction__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("-")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_subtraction__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 -")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_subtraction__more_than_two_values_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 12 3 -")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 9})
}

@(test)
test_multiplication__can_multiply_two_numbers :: proc(t: ^testing.T) {

	result, error := evaluate("2 4 *")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{8})
}

@(test)
test_multiplication__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("*")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_multiplication__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 *")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_multiplication__more_than_two_values_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 3 *")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 6})
}

@(test)
test_division__can_divide_two_numbers :: proc(t: ^testing.T) {

	result, error := evaluate("12 3 /")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{4})
}

@(test)
test_division__performs_integer_division :: proc(t: ^testing.T) {

	result, error := evaluate("8 3 /")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{2})
}

@(test)
test_division__errors_if_dividing_by_zero :: proc(t: ^testing.T) {

	result, error := evaluate("4 0 /")
	defer delete(result)

	testing.expect_value(t, error, Error.Divide_By_Zero)
}

@(test)
test_division__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("/")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_division__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 /")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_division__more_than_two_values_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 12 3 /")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 4})
}

@(test)
test_combined_arithmetic__addition_and_subtraction :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 + 4 -")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{-1})
}

@(test)
test_combined_arithmetic__multiplication_and_division :: proc(t: ^testing.T) {

	result, error := evaluate("2 4 * 3 /")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{2})
}

@(test)
test_combined_arithmetic__multiplication_and_addition :: proc(t: ^testing.T) {

	result, error := evaluate("1 3 4 * +")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{13})
}

@(test)
test_combined_arithmetic__addition_and_multiplication :: proc(t: ^testing.T) {

	result, error := evaluate("1 3 4 + *")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{7})
}

@(test)
test_dup__copies_a_value_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 dup")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 1})
}

@(test)
test_dup__copies_the_top_value_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 dup")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 2, 2})
}

@(test)
test_dup__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("dup")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_drop__removes_the_top_value_on_the_stack_if_it_is_the_only_one :: proc(t: ^testing.T) {

	result, error := evaluate("1 drop")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{})
}

@(test)
test_drop__removes_the_top_value_on_the_stack_if_it_is_not_the_only_one :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 drop")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1})
}

@(test)
test_drop__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("drop")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_swap__swaps_the_top_two_values_on_the_stack_if_they_are_the_only_ones :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 swap")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{2, 1})
}

@(test)
test_swap__swaps_the_top_two_values_on_the_stack_if_they_are_not_the_only_ones :: proc(
	t: ^testing.T,
) {

	result, error := evaluate("1 2 3 swap")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 3, 2})
}

@(test)
test_swap__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("swap")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_swap__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 swap")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_over__copies_the_second_element_if_there_are_only_two :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 over")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 2, 1})
}

@(test)
test_over__copies_the_second_element_if_there_are_more_than_two :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 3 over")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 2, 3, 2})
}

@(test)
test_over__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("over")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_over__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	result, error := evaluate("1 over")
	defer delete(result)

	testing.expect_value(t, error, Error.Stack_Underflow)
}

@(test)
test_user_defined_words__can_consist_of_built_in_words :: proc(t: ^testing.T) {

	result, error := evaluate(": dup-twice dup dup ;", "1 dup-twice")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 1, 1})
}

@(test)
test_user_defined_words__execute_in_the_right_order :: proc(t: ^testing.T) {

	result, error := evaluate(": countup 1 2 3 ;", "countup")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 2, 3})
}

@(test)
test_user_defined_words__can_override_other_user_defined_words :: proc(t: ^testing.T) {

	result, error := evaluate(": foo dup ;", ": foo dup dup ;", "1 foo")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 1, 1})
}

@(test)
test_user_defined_words__can_override_built_in_words :: proc(t: ^testing.T) {

	result, error := evaluate(": swap dup ;", "1 swap")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 1})
}

@(test)
test_user_defined_words__can_override_built_in_operators :: proc(t: ^testing.T) {

	result, error := evaluate(": + * ;", "3 4 +")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{12})
}

@(test)
test_user_defined_words__can_use_different_words_with_the_same_name :: proc(t: ^testing.T) {

	result, error := evaluate(": foo 5 ;", ": bar foo ;", ": foo 6 ;", "bar foo")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{5, 6})
}

@(test)
test_user_defined_words__can_define_word_that_uses_word_with_the_same_name :: proc(t: ^testing.T) {

	result, error := evaluate(": foo 10 ;", ": foo foo 1 + ;", "foo")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{11})
}

@(test)
test_user_defined_words__cannot_redefine_non_negative_numbers :: proc(t: ^testing.T) {

	result, error := evaluate(": 1 2 ;")
	defer delete(result)

	testing.expect_value(t, error, Error.Cant_Redefine_Number)
}

@(test)
test_user_defined_words__cannot_redefine_negative_numbers :: proc(t: ^testing.T) {

	result, error := evaluate(": -1 2 ;")
	defer delete(result)

	testing.expect_value(t, error, Error.Cant_Redefine_Number)
}

@(test)
test_user_defined_words__errors_if_executing_a_non_existent_word :: proc(t: ^testing.T) {

	result, error := evaluate("foo")
	defer delete(result)

	testing.expect_value(t, error, Error.Unknown_Word)
}

@(test)
test_user_defined_words__only_defines_locally :: proc(t: ^testing.T) {

	result1, error1 := evaluate(": + - ;", "1 1 +")
	defer delete(result1)

	testing.expect_value(t, error1, Error.None)
	expect_slices_match(t, result1, []int{0})

	result2, error2 := evaluate("1 1 +")
	defer delete(result2)

	testing.expect_value(t, error2, Error.None)
	expect_slices_match(t, result2, []int{2})
}

@(test)
test_case_insensitivity__dup_is_case_insensitive :: proc(t: ^testing.T) {

	result, error := evaluate("1 DUP Dup dup")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 1, 1, 1})
}

@(test)
test_case_insensitivity__drop_is_case_insensitive :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 3 4 DROP Drop drop")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1})
}

@(test)
test_case_insensitivity__swap_is_case_insensitive :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 SWAP 3 Swap 4 swap")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{2, 3, 4, 1})
}

@(test)
test_case_insensitivity__over_is_case_insensitive :: proc(t: ^testing.T) {

	result, error := evaluate("1 2 OVER Over over")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 2, 1, 2, 1})
}

@(test)
test_case_insensitivity__user_defined_words_are_case_insensitive :: proc(t: ^testing.T) {

	result, error := evaluate(": foo dup ;", "1 FOO Foo foo")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 1, 1, 1})
}

@(test)
test_case_insensitivity__definitions_are_case_insensitive :: proc(t: ^testing.T) {

	result, error := evaluate(": SWAP DUP Dup dup ;", "1 swap")
	defer delete(result)

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, []int{1, 1, 1, 1})
}
