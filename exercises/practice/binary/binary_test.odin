/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package binary

import "core:testing"

check_convert_values :: proc(
	t: ^testing.T,
	input: string,
	want_output: int,
	want_ok: bool,
) {
	v, ok := convert(input)
	testing.expect_value(t, want_output, v)
	testing.expect_value(t, want_ok, ok)
}

@(test)
test_binary_0_is_decimal_0 :: proc(t: ^testing.T) {
	check_convert_values(t, "0", 0, true)
}

// @(test)
test_binary_1_is_decimal_1 :: proc(t: ^testing.T) {
	check_convert_values(t, "1", 1, true)
}

// @(test)
test_binary_10_is_decimal_2 :: proc(t: ^testing.T) {
	check_convert_values(t, "10", 2, true)
}

// @(test)
test_binary_11_is_decimal_3 :: proc(t: ^testing.T) {
	check_convert_values(t, "11", 3, true)
}

// @(test)
test_binary_100_is_decimal_4 :: proc(t: ^testing.T) {
	check_convert_values(t, "100", 4, true)
}

// @(test)
test_binary_1001_is_decimal_9 :: proc(t: ^testing.T) {
	check_convert_values(t, "1001", 9, true)
}

// @(test)
test_binary_11010_is_decimal_26 :: proc(t: ^testing.T) {
	check_convert_values(t, "11010", 26, true)
}

// @(test)
test_binary_10001101000_is_decimal_1128 :: proc(t: ^testing.T) {
	check_convert_values(t, "10001101000", 1128, true)
}

// @(test)
test_binary_ignores_leading_zeros :: proc(t: ^testing.T) {
	check_convert_values(t, "000011111", 31, true)
}

// @(test)
test_2_is_not_a_valid_binary_digit :: proc(t: ^testing.T) {
	check_convert_values(t, "2", 0, false)
}

// @(test)
test_a_number_containing_a_non_binary_digit_is_invalid :: proc(t: ^testing.T) {
	check_convert_values(t, "01201", 0, false)
}

// @(test)
test_a_number_with_trailing_non_binary_characters_is_invalid :: proc(
	t: ^testing.T,
) {
	check_convert_values(t, "10nope", 0, false)
}

// @(test)
test_a_number_with_leading_non_binary_characters_is_invalid :: proc(
	t: ^testing.T,
) {
	check_convert_values(t, "nope10", 0, false)
}

// @(test)
test_a_number_with_internal_non_binary_characters_is_invalid :: proc(
	t: ^testing.T,
) {
	check_convert_values(t, "10nope10", 0, false)
}

// @(test)
test_a_number_and_a_word_whitespace_separated_is_invalid :: proc(
	t: ^testing.T,
) {
	check_convert_values(t, "001 nope", 0, false)
}
