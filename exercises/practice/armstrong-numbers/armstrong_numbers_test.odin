package armstrong_numbers

import "core:testing"

@(test)
test_zero :: proc(t: ^testing.T) {
	testing.expect(t, is_armstrong_number(0), "zero is an armstrong number")
}

@(test)
test_single_digit :: proc(t: ^testing.T) {
	testing.expect(t, is_armstrong_number(5), "single-digit numbers are armstrong numbers")
}

@(test)
test_two_digit :: proc(t: ^testing.T) {
	testing.expect(t, !is_armstrong_number(10), "there are no two-digit armstrong numbers")
}

@(test)
test_three_digit_armstrong :: proc(t: ^testing.T) {
	testing.expect(t, is_armstrong_number(153), "three-digit number that is an armstrong number")
}

@(test)
test_three_digit_non_armstrong :: proc(t: ^testing.T) {
	testing.expect(
		t,
		!is_armstrong_number(100),
		"three-digit number that is not an armstrong number",
	)
}

@(test)
test_four_digit_armstrong :: proc(t: ^testing.T) {
	testing.expect(t, is_armstrong_number(9_474), "four-digit number that is an armstrong number")
}

@(test)
test_four_digit_non_armstrong :: proc(t: ^testing.T) {
	testing.expect(
		t,
		!is_armstrong_number(9_475),
		"four-digit number that is not an armstrong number",
	)
}

@(test)
test_seven_digit_armstrong :: proc(t: ^testing.T) {
	testing.expect(
		t,
		is_armstrong_number(9_926_315),
		"seven-digit number that is an armstrong number",
	)
}

@(test)
test_seven_digit_non_armstrong :: proc(t: ^testing.T) {
	testing.expect(
		t,
		!is_armstrong_number(9_926_314),
		"seven-digit number that is not an armstrong number",
	)
}

@(test)
test_33_digit_armstrong :: proc(t: ^testing.T) {
	testing.expect(
		t,
		is_armstrong_number(186_709_961_001_538_790_100_634_132_976_990),
		"33-digit number that is an armstrong number",
	)
}

@(test)
test_38_digit_non_armstrong :: proc(t: ^testing.T) {
	testing.expect(
		t,
		!is_armstrong_number(99_999_999_999_999_999_999_999_999_999_999_999_999),
		"38-digit number that is not an armstrong number",
	)
}

@(test)
test_largest_armstrong :: proc(t: ^testing.T) {
	testing.expect(
		t,
		is_armstrong_number(115_132_219_018_763_992_565_095_597_973_971_522_401),
		"the largest and last armstrong number",
	)
}

@(test)
test_largest_u128 :: proc(t: ^testing.T) {
	testing.expect(
		t,
		!is_armstrong_number(340_282_366_920_938_463_463_374_607_431_768_211_455),
		"the largest 128-bit unsigned integer value is not an armstrong number",
	)
}
