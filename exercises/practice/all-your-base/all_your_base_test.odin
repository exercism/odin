package all_your_base

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
/// description = single bit one to decimal
test_single_bit_one_to_decimal :: proc(t: ^testing.T) {
	input_base := 2
	digits := [?]int{1}
	output_base := 10
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{1}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = binary to single decimal
test_binary_to_single_decimal :: proc(t: ^testing.T) {
	input_base := 2
	digits := [?]int{1, 0, 1}
	output_base := 10
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{5}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = single decimal to binary
test_single_decimal_to_binary :: proc(t: ^testing.T) {
	input_base := 10
	digits := [?]int{5}
	output_base := 2
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{1, 0, 1}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = binary to multiple decimal
test_binary_to_multiple_decimal :: proc(t: ^testing.T) {
	input_base := 2
	digits := [?]int{1, 0, 1, 0, 1, 0}
	output_base := 10
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{4, 2}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = decimal to binary
test_decimal_to_binary :: proc(t: ^testing.T) {
	input_base := 10
	digits := [?]int{4, 2}
	output_base := 2
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{1, 0, 1, 0, 1, 0}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = trinary to hexadecimal
test_trinary_to_hexadecimal :: proc(t: ^testing.T) {
	input_base := 3
	digits := [?]int{1, 1, 2, 0}
	output_base := 16
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{2, 10}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = hexadecimal to trinary
test_hexadecimal_to_trinary :: proc(t: ^testing.T) {
	input_base := 16
	digits := [?]int{2, 10}
	output_base := 3
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{1, 1, 2, 0}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = 15-bit integer
test_15_bit_integer :: proc(t: ^testing.T) {
	input_base := 97
	digits := [?]int{3, 46, 60}
	output_base := 73
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{6, 10, 45}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = empty list
test_empty_list :: proc(t: ^testing.T) {
	input_base := 2
	digits := [?]int{}
	output_base := 10
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{0}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = single zero
test_single_zero :: proc(t: ^testing.T) {
	input_base := 10
	digits := [?]int{0}
	output_base := 2
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{0}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = multiple zeros
test_multiple_zeros :: proc(t: ^testing.T) {
	input_base := 10
	digits := [?]int{0, 0, 0}
	output_base := 2
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{0}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = leading zeros
test_leading_zeros :: proc(t: ^testing.T) {
	input_base := 7
	digits := [?]int{0, 6, 0}
	output_base := 10
	result, err := rebase(input_base, digits[:], output_base)
	defer delete(result)

	expected := [?]int{4, 2}
	expect_slices_match(t, result, expected[:])
	testing.expect_value(t, err, Error.None)
}

@(test)
/// description = input base is one
test_input_base_is_one :: proc(t: ^testing.T) {
	input_base := 1
	digits := [?]int{0}
	output_base := 10
	_, err := rebase(input_base, digits[:], output_base)

	testing.expect_value(t, err, Error.Input_Base_Too_Small)
}

@(test)
/// description = input base is zero
test_input_base_is_zero :: proc(t: ^testing.T) {
	input_base := 0
	digits := [?]int{}
	output_base := 10
	_, err := rebase(input_base, digits[:], output_base)

	testing.expect_value(t, err, Error.Input_Base_Too_Small)
}

@(test)
/// description = input base is negative
test_input_base_is_negative :: proc(t: ^testing.T) {
	input_base := -2
	digits := [?]int{1}
	output_base := 10
	_, err := rebase(input_base, digits[:], output_base)

	testing.expect_value(t, err, Error.Input_Base_Too_Small)
}

@(test)
/// description = negative digit
test_negative_digit :: proc(t: ^testing.T) {
	input_base := 2
	digits := [?]int{1, -1, 1, 0, 1, 0}
	output_base := 10
	_, err := rebase(input_base, digits[:], output_base)

	testing.expect_value(t, err, Error.Invalid_Input_Digit)
}

@(test)
/// description = invalid positive digit
test_invalid_positive_digit :: proc(t: ^testing.T) {
	input_base := 2
	digits := [?]int{1, 2, 1, 0, 1, 0}
	output_base := 10
	_, err := rebase(input_base, digits[:], output_base)

	testing.expect_value(t, err, Error.Invalid_Input_Digit)
}

@(test)
/// description = output base is one
test_output_base_is_one :: proc(t: ^testing.T) {
	input_base := 2
	digits := [?]int{1, 0, 1, 0, 1, 0}
	output_base := 1
	_, err := rebase(input_base, digits[:], output_base)

	testing.expect_value(t, err, Error.Output_Base_Too_Small)
}

@(test)
/// description = output base is zero
test_output_base_is_zero :: proc(t: ^testing.T) {
	input_base := 10
	digits := [?]int{7}
	output_base := 0
	_, err := rebase(input_base, digits[:], output_base)

	testing.expect_value(t, err, Error.Output_Base_Too_Small)
}

@(test)
/// description = output base is negative
test_output_base_is_negative :: proc(t: ^testing.T) {
	input_base := 2
	digits := [?]int{1}
	output_base := -7
	_, err := rebase(input_base, digits[:], output_base)

	testing.expect_value(t, err, Error.Output_Base_Too_Small)
}

@(test)
/// description = both bases are negative
test_both_bases_are_negative :: proc(t: ^testing.T) {
	input_base := -2
	digits := [?]int{1}
	output_base := -7
	_, err := rebase(input_base, digits[:], output_base)

	testing.expect_value(t, err, Error.Input_Base_Too_Small)
}
