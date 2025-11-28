package forth

import "core:fmt"
import "core:testing"

/* ------------------------------------------------------------
 * A helper procedure to enable more helpful test failure output.
 * Stringify the slices and compare the strings.
 * If they don't match, the user will see the values.
 */
expect_slices_match :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {
	result := fmt.aprintf("%v", actual) // this varname shows up in the test output
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str)
}

@(test)
test_parsing_and_numbers__numbers_just_get_pushed_onto_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 2 3 4 5"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 2, 3, 4, 5}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_parsing_and_numbers__pushes_negative_numbers_onto_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"-1 -2 -3 -4 -5"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{-1, -2, -3, -4, -5}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_addition__can_add_two_numbers :: proc(t: ^testing.T) {

	input := [?]string{"1 2 +"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{3}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])}

@(test)
test_addition__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"+"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_addition__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 +"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_addition__more_than_two_values_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 2 3 +"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 5}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_subtraction__can_subtract_two_numbers :: proc(t: ^testing.T) {

	input := [?]string{"3 4 -"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{-1}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_subtraction__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"-"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_subtraction__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 -"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_subtraction__more_than_two_values_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 12 3 -"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 9}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_multiplication__can_multiply_two_numbers :: proc(t: ^testing.T) {

	input := [?]string{"2 4 *"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{8}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_multiplication__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"*"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_multiplication__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 *"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_multiplication__more_than_two_values_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 2 3 *"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 6}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_division__can_divide_two_numbers :: proc(t: ^testing.T) {

	input := [?]string{"12 3 /"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{4}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_division__performs_integer_division :: proc(t: ^testing.T) {

	input := [?]string{"8 3 /"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{2}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_division__errors_if_dividing_by_zero :: proc(t: ^testing.T) {

	input := [?]string{"4 0 /"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Divide_By_Zero)
}

@(test)
test_division__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"/"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_division__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 /"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_division__more_than_two_values_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 12 3 /"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 4}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_combined_arithmetic__addition_and_subtraction :: proc(t: ^testing.T) {

	input := [?]string{"1 2 + 4 -"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{-1}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_combined_arithmetic__multiplication_and_division :: proc(t: ^testing.T) {

	input := [?]string{"2 4 * 3 /"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{2}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_combined_arithmetic__multiplication_and_addition :: proc(t: ^testing.T) {

	input := [?]string{"1 3 4 * +"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{13}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_combined_arithmetic__addition_and_multiplication :: proc(t: ^testing.T) {

	input := [?]string{"1 3 4 + *"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{7}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_dup__copies_a_value_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 dup"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 1}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_dup__copies_the_top_value_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 2 dup"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 2, 2}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_dup__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"dup"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_drop__removes_the_top_value_on_the_stack_if_it_is_the_only_one :: proc(t: ^testing.T) {

	input := [?]string{"1 drop"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_drop__removes_the_top_value_on_the_stack_if_it_is_not_the_only_one :: proc(t: ^testing.T) {

	input := [?]string{"1 2 drop"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_drop__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"drop"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_swap__swaps_the_top_two_values_on_the_stack_if_they_are_the_only_ones :: proc(t: ^testing.T) {

	input := [?]string{"1 2 swap"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{2, 1}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_swap__swaps_the_top_two_values_on_the_stack_if_they_are_not_the_only_ones :: proc(
	t: ^testing.T,
) {

	input := [?]string{"1 2 3 swap"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 3, 2}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_swap__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"swap"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_swap__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 swap"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_over__copies_the_second_element_if_there_are_only_two :: proc(t: ^testing.T) {

	input := [?]string{"1 2 over"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 2, 1}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_over__copies_the_second_element_if_there_are_more_than_two :: proc(t: ^testing.T) {

	input := [?]string{"1 2 3 over"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 2, 3, 2}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_over__errors_if_there_is_nothing_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"over"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_over__errors_if_there_is_only_one_value_on_the_stack :: proc(t: ^testing.T) {

	input := [?]string{"1 over"}
	result, error := evaluate(input[:])
	defer delete(result)

	testing.expect_value(t, error, Error.Not_Enough_Elements_On_Stack)
}

@(test)
test_user_defined_words__can_consist_of_built_in_words :: proc(t: ^testing.T) {

	input := [?]string{": dup-twice dup dup ;", "1 dup-twice"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 1, 1}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
test_user_defined_words__execute_in_the_right_order :: proc(t: ^testing.T) {

	input := [?]string{": countup 1 2 3 ;", "countup"}
	result, error := evaluate(input[:])
	defer delete(result)
	expected := [?]int{1, 2, 3}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

/*
@(test)
test_user_defined_words__can_override_other_user_defined_words :: proc(t: ^testing.T) {
    input := `{"instructions":[": foo dup ;",": foo dup dup ;","1 foo"]}`
    result := evaluate(input)
    expected := [1,1,1]

    testing.expect_value(t, result, expected)
}

@(test)
test_user_defined_words__can_override_built_in_words :: proc(t: ^testing.T) {
    input := `{"instructions":[": swap dup ;","1 swap"]}`
    result := evaluate(input)
    expected := [1,1]

    testing.expect_value(t, result, expected)
}

@(test)
test_user_defined_words__can_override_built_in_operators :: proc(t: ^testing.T) {
    input := `{"instructions":[": + * ;","3 4 +"]}`
    result := evaluate(input)
    expected := [12]

    testing.expect_value(t, result, expected)
}

@(test)
test_user_defined_words__can_use_different_words_with_the_same_name :: proc(t: ^testing.T) {
    input := `{"instructions":[": foo 5 ;",": bar foo ;",": foo 6 ;","bar foo"]}`
    result := evaluate(input)
    expected := [5,6]

    testing.expect_value(t, result, expected)
}

@(test)
test_user_defined_words__can_define_word_that_uses_word_with_the_same_name :: proc(t: ^testing.T) {
    input := `{"instructions":[": foo 10 ;",": foo foo 1 + ;","foo"]}`
    result := evaluate(input)
    expected := [11]

    testing.expect_value(t, result, expected)
}

@(test)
test_user_defined_words__cannot_redefine_non_negative_numbers :: proc(t: ^testing.T) {
    input := `{"instructions":[": 1 2 ;"]}`
    result := evaluate(input)
    expected := {"error":"illegal operation"}

    testing.expect_value(t, result, expected)
}

@(test)
test_user_defined_words__cannot_redefine_negative_numbers :: proc(t: ^testing.T) {
    input := `{"instructions":[": -1 2 ;"]}`
    result := evaluate(input)
    expected := {"error":"illegal operation"}

    testing.expect_value(t, result, expected)
}

@(test)
test_user_defined_words__errors_if_executing_a_non_existent_word :: proc(t: ^testing.T) {
    input := `{"instructions":["foo"]}`
    result := evaluate(input)
    expected := {"error":"undefined operation"}

    testing.expect_value(t, result, expected)
}

@(test)
test_user_defined_words__only_defines_locally :: proc(t: ^testing.T) {
    input := `{"instructionsFirst":[": + - ;","1 1 +"],"instructionsSecond":["1 1 +"]}`
    result := evaluate_both(input)
    expected := [[0],[2]]

    testing.expect_value(t, result, expected)
}

@(test)
test_case_insensitivity__dup_is_case_insensitive :: proc(t: ^testing.T) {
    input := `{"instructions":["1 DUP Dup dup"]}`
    result := evaluate(input)
    expected := [1,1,1,1]

    testing.expect_value(t, result, expected)
}

@(test)
test_case_insensitivity__drop_is_case_insensitive :: proc(t: ^testing.T) {
    input := `{"instructions":["1 2 3 4 DROP Drop drop"]}`
    result := evaluate(input)
    expected := [1]

    testing.expect_value(t, result, expected)
}

@(test)
test_case_insensitivity__swap_is_case_insensitive :: proc(t: ^testing.T) {
    input := `{"instructions":["1 2 SWAP 3 Swap 4 swap"]}`
    result := evaluate(input)
    expected := [2,3,4,1]

    testing.expect_value(t, result, expected)
}

@(test)
test_case_insensitivity__over_is_case_insensitive :: proc(t: ^testing.T) {
    input := `{"instructions":["1 2 OVER Over over"]}`
    result := evaluate(input)
    expected := [1,2,1,2,1]

    testing.expect_value(t, result, expected)
}

@(test)
test_case_insensitivity__user_defined_words_are_case_insensitive :: proc(t: ^testing.T) {
    input := `{"instructions":[": foo dup ;","1 FOO Foo foo"]}`
    result := evaluate(input)
    expected := [1,1,1,1]

    testing.expect_value(t, result, expected)
}

@(test)
test_case_insensitivity__definitions_are_case_insensitive :: proc(t: ^testing.T) {
    input := `{"instructions":[": SWAP DUP Dup dup ;","1 swap"]}`
    result := evaluate(input)
    expected := [1,1,1,1]

    testing.expect_value(t, result, expected)
}
*/
