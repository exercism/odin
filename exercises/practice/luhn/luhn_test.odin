package luhn

import "core:testing"

@(test)
/// description = single digit strings can not be valid
test_single_digit_strings_can_not_be_valid :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("1"), false)
}

@(test)
/// description = a single zero is invalid
test_a_single_zero_is_invalid :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("0"), false)
}

@(test)
/// description = a simple valid SIN that remains valid if reversed
test_a_simple_valid_sin_that_remains_valid_if_reversed :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("059"), true)
}

@(test)
/// description = a simple valid SIN that becomes invalid if reversed
test_a_simple_valid_sin_that_becomes_invalid_if_reversed :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("59"), true)
}

@(test)
/// description = a valid Canadian SIN
test_a_valid_canadian_sin :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("055 444 285"), true)
}

@(test)
/// description = invalid Canadian SIN
test_invalid_canadian_sin :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("055 444 286"), false)
}

@(test)
/// description = invalid credit card
test_invalid_credit_card :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("8273 1232 7352 0569"), false)
}

@(test)
/// description = invalid long number with an even remainder
test_invalid_long_number_with_an_even_remainder :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("1 2345 6789 1234 5678 9012"), false)
}

@(test)
/// description = invalid long number with a remainder divisible by 5
test_invalid_long_number_with_a_remainder_divisible_by_5 :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("1 2345 6789 1234 5678 9013"), false)
}

@(test)
/// description = valid number with an even number of digits
test_valid_number_with_an_even_number_of_digits :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("095 245 88"), true)
}

@(test)
/// description = valid number with an odd number of spaces
test_valid_number_with_an_odd_number_of_spaces :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("234 567 891 234"), true)
}

@(test)
/// description = valid strings with a non-digit added at the end become invalid
test_valid_strings_with_a_non_digit_added_at_the_end_become_invalid :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("059a"), false)
}

@(test)
/// description = valid strings with punctuation included become invalid
test_valid_strings_with_punctuation_included_become_invalid :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("055-444-285"), false)
}

@(test)
/// description = valid strings with symbols included become invalid
test_valid_strings_with_symbols_included_become_invalid :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("055# 444$ 285"), false)
}

@(test)
/// description = single zero with space is invalid
test_single_zero_with_space_is_invalid :: proc(t: ^testing.T) {
	testing.expect_value(t, valid(" 0"), false)
}

@(test)
/// description = more than a single zero is valid
test_more_than_a_single_zero_is_valid :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("0000 0"), true)
}

@(test)
/// description = input digit 9 is correctly converted to output digit 9
test_input_digit_9_is_correctly_converted_to_output_digit_9 :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("091"), true)
}

@(test)
/// description = very long input is valid
test_very_long_input_is_valid :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("9999999999 9999999999 9999999999 9999999999"), true)
}

@(test)
/// description = valid luhn with an odd number of digits and non zero first digit
test_valid_luhn_with_an_odd_number_of_digits_and_non_zero_first_digit :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("109"), true)
}

@(test)
/// description = using ascii value for non-doubled non-digit isn't allowed
test_using_ascii_value_for_non_doubled_non_digit_isnt_allowed :: proc(t: ^testing.T) {
	testing.expect_value(t, valid("055b 444 285"), false)
}

@(test)
/// description = using ascii value for doubled non-digit isn't allowed
test_using_ascii_value_for_doubled_non_digit_isnt_allowed :: proc(t: ^testing.T) {
	testing.expect_value(t, valid(":9"), false)
}

@(test)
/// description = non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed
test_non_numeric_non_space_char_in_the_middle_with_a_sum_thats_divisible_by_10_isnt_allowed :: proc(
	t: ^testing.T,
) {
	testing.expect_value(t, valid("59%59"), false)
}
