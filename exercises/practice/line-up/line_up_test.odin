package line_up

import "core:testing"

@(test)
/// description = format smallest non-exceptional ordinal numeral 4
test_format_smallest_non_exceptional_ordinal_numeral_4 :: proc(t: ^testing.T) {
	formatted := format("Gianna", 4)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Gianna, you are the 4th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format greatest single digit non-exceptional ordinal numeral 9
test_format_greatest_single_digit_non_exceptional_ordinal_numeral_9 :: proc(t: ^testing.T) {
	formatted := format("Maarten", 9)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Maarten, you are the 9th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format non-exceptional ordinal numeral 5
test_format_non_exceptional_ordinal_numeral_5 :: proc(t: ^testing.T) {
	formatted := format("Petronila", 5)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Petronila, you are the 5th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format non-exceptional ordinal numeral 6
test_format_non_exceptional_ordinal_numeral_6 :: proc(t: ^testing.T) {
	formatted := format("Attakullakulla", 6)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Attakullakulla, you are the 6th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format non-exceptional ordinal numeral 7
test_format_non_exceptional_ordinal_numeral_7 :: proc(t: ^testing.T) {
	formatted := format("Kate", 7)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Kate, you are the 7th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format non-exceptional ordinal numeral 8
test_format_non_exceptional_ordinal_numeral_8 :: proc(t: ^testing.T) {
	formatted := format("Maximiliano", 8)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Maximiliano, you are the 8th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format exceptional ordinal numeral 1
test_format_exceptional_ordinal_numeral_1 :: proc(t: ^testing.T) {
	formatted := format("Mary", 1)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Mary, you are the 1st customer we serve today. Thank you!",
	)
}

@(test)
/// description = format exceptional ordinal numeral 2
test_format_exceptional_ordinal_numeral_2 :: proc(t: ^testing.T) {
	formatted := format("Haruto", 2)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Haruto, you are the 2nd customer we serve today. Thank you!",
	)
}

@(test)
/// description = format exceptional ordinal numeral 3
test_format_exceptional_ordinal_numeral_3 :: proc(t: ^testing.T) {
	formatted := format("Henriette", 3)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Henriette, you are the 3rd customer we serve today. Thank you!",
	)
}

@(test)
/// description = format smallest two digit non-exceptional ordinal numeral 10
test_format_smallest_two_digit_non_exceptional_ordinal_numeral_10 :: proc(t: ^testing.T) {
	formatted := format("Alvarez", 10)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Alvarez, you are the 10th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format non-exceptional ordinal numeral 11
test_format_non_exceptional_ordinal_numeral_11 :: proc(t: ^testing.T) {
	formatted := format("Jacqueline", 11)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Jacqueline, you are the 11th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format non-exceptional ordinal numeral 12
test_format_non_exceptional_ordinal_numeral_12 :: proc(t: ^testing.T) {
	formatted := format("Juan", 12)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Juan, you are the 12th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format non-exceptional ordinal numeral 13
test_format_non_exceptional_ordinal_numeral_13 :: proc(t: ^testing.T) {
	formatted := format("Patricia", 13)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Patricia, you are the 13th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format exceptional ordinal numeral 21
test_format_exceptional_ordinal_numeral_21 :: proc(t: ^testing.T) {
	formatted := format("Washi", 21)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Washi, you are the 21st customer we serve today. Thank you!",
	)
}

@(test)
/// description = format exceptional ordinal numeral 62
test_format_exceptional_ordinal_numeral_62 :: proc(t: ^testing.T) {
	formatted := format("Nayra", 62)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Nayra, you are the 62nd customer we serve today. Thank you!",
	)
}

@(test)
/// description = format exceptional ordinal numeral 100
test_format_exceptional_ordinal_numeral_100 :: proc(t: ^testing.T) {
	formatted := format("John", 100)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"John, you are the 100th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format exceptional ordinal numeral 101
test_format_exceptional_ordinal_numeral_101 :: proc(t: ^testing.T) {
	formatted := format("Zeinab", 101)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Zeinab, you are the 101st customer we serve today. Thank you!",
	)
}

@(test)
/// description = format non-exceptional ordinal numeral 112
test_format_non_exceptional_ordinal_numeral_112 :: proc(t: ^testing.T) {
	formatted := format("Knud", 112)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Knud, you are the 112th customer we serve today. Thank you!",
	)
}

@(test)
/// description = format exceptional ordinal numeral 123
test_format_exceptional_ordinal_numeral_123 :: proc(t: ^testing.T) {
	formatted := format("Yma", 123)
	defer delete(formatted)
	testing.expect_value(
		t,
		formatted,
		"Yma, you are the 123rd customer we serve today. Thank you!",
	)
}
