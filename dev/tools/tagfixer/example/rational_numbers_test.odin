package rational_numbers

import "core:math"
import "core:testing"

@(test)
test_arithmetic__addition__add_two_positive_rational_numbers :: proc(t: ^testing.T) {
	r1 := Rational{1, 2}
	r2 := Rational{2, 3}

	result := add(r1, r2)
	expected := Rational{7, 6}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__addition__add_a_positive_rational_number_and_a_negative_rational_number :: proc(
	t: ^testing.T,
) {
	r1 := Rational{1, 2}
	r2 := Rational{-2, 3}

	result := add(r1, r2)
	expected := Rational{-1, 6}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__addition__add_two_negative_rational_numbers :: proc(t: ^testing.T) {
	r1 := Rational{-1, 2}
	r2 := Rational{-2, 3}

	result := add(r1, r2)
	expected := Rational{-7, 6}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__addition__add_a_rational_number_to_its_additive_inverse :: proc(t: ^testing.T) {
	r1 := Rational{1, 2}
	r2 := Rational{-1, 2}

	result := add(r1, r2)
	expected := Rational{0, 1}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__subtraction__subtract_two_positive_rational_numbers :: proc(t: ^testing.T) {
	r1 := Rational{1, 2}
	r2 := Rational{2, 3}

	result := sub(r1, r2)
	expected := Rational{-1, 6}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__subtraction__subtract_a_positive_rational_number_and_a_negative_rational_number :: proc(
	t: ^testing.T,
) {
	r1 := Rational{1, 2}
	r2 := Rational{-2, 3}

	result := sub(r1, r2)
	expected := Rational{7, 6}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__subtraction__subtract_two_negative_rational_numbers :: proc(t: ^testing.T) {
	r1 := Rational{-1, 2}
	r2 := Rational{-2, 3}

	result := sub(r1, r2)
	expected := Rational{1, 6}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__subtraction__subtract_a_rational_number_from_itself :: proc(t: ^testing.T) {
	r1 := Rational{1, 2}
	r2 := Rational{1, 2}

	result := sub(r1, r2)
	expected := Rational{0, 1}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__multiplication__multiply_two_positive_rational_numbers :: proc(t: ^testing.T) {
	r1 := Rational{1, 2}
	r2 := Rational{2, 3}

	result := mul(r1, r2)
	expected := Rational{1, 3}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__multiplication__multiply_a_negative_rational_number_by_a_positive_rational_number :: proc(
	t: ^testing.T,
) {
	r1 := Rational{-1, 2}
	r2 := Rational{2, 3}

	result := mul(r1, r2)
	expected := Rational{-1, 3}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__multiplication__multiply_two_negative_rational_numbers :: proc(t: ^testing.T) {
	r1 := Rational{-1, 2}
	r2 := Rational{-2, 3}

	result := mul(r1, r2)
	expected := Rational{1, 3}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__multiplication__multiply_a_rational_number_by_its_reciprocal :: proc(
	t: ^testing.T,
) {
	r1 := Rational{1, 2}
	r2 := Rational{2, 1}

	result := mul(r1, r2)
	expected := Rational{1, 1}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__multiplication__multiply_a_rational_number_by_1 :: proc(t: ^testing.T) {
	r1 := Rational{1, 2}
	r2 := Rational{1, 1}

	result := mul(r1, r2)
	expected := Rational{1, 2}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__multiplication__multiply_a_rational_number_by_0 :: proc(t: ^testing.T) {
	r1 := Rational{1, 2}
	r2 := Rational{0, 1}

	result := mul(r1, r2)
	expected := Rational{0, 1}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__division__divide_two_positive_rational_numbers :: proc(t: ^testing.T) {
	r1 := Rational{1, 2}
	r2 := Rational{2, 3}

	result := div(r1, r2)
	expected := Rational{3, 4}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__division__divide_a_positive_rational_number_by_a_negative_rational_number :: proc(
	t: ^testing.T,
) {
	r1 := Rational{1, 2}
	r2 := Rational{-2, 3}

	result := div(r1, r2)
	expected := Rational{-3, 4}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__division__divide_two_negative_rational_numbers :: proc(t: ^testing.T) {
	r1 := Rational{-1, 2}
	r2 := Rational{-2, 3}

	result := div(r1, r2)
	expected := Rational{3, 4}

	testing.expect_value(t, result, expected)
}

@(test)
test_arithmetic__division__divide_a_rational_number_by_1 :: proc(t: ^testing.T) {
	r1 := Rational{1, 2}
	r2 := Rational{1, 1}

	result := div(r1, r2)
	expected := Rational{1, 2}

	testing.expect_value(t, result, expected)
}

@(test)
test_absolute_value__absolute_value_of_a_positive_rational_number :: proc(t: ^testing.T) {
	r := Rational{1, 2}

	result := abs(r)
	expected := Rational{1, 2}

	testing.expect_value(t, result, expected)
}

@(test)
test_absolute_value__absolute_value_of_a_positive_rational_number_with_negative_numerator_and_denominator :: proc(
	t: ^testing.T,
) {
	r := Rational{-1, -2}

	result := abs(r)
	expected := Rational{1, 2}

	testing.expect_value(t, result, expected)
}

@(test)
test_absolute_value__absolute_value_of_a_negative_rational_number :: proc(t: ^testing.T) {
	r := Rational{-1, 2}

	result := abs(r)
	expected := Rational{1, 2}

	testing.expect_value(t, result, expected)
}

@(test)
test_absolute_value__absolute_value_of_a_negative_rational_number_with_negative_denominator :: proc(
	t: ^testing.T,
) {
	r := Rational{1, -2}

	result := abs(r)
	expected := Rational{1, 2}

	testing.expect_value(t, result, expected)
}

@(test)
test_absolute_value__absolute_value_of_zero :: proc(t: ^testing.T) {
	r := Rational{0, 1}

	result := abs(r)
	expected := Rational{0, 1}

	testing.expect_value(t, result, expected)
}

@(test)
test_absolute_value__absolute_value_of_a_rational_number_is_reduced_to_lowest_terms :: proc(
	t: ^testing.T,
) {
	r := Rational{2, 4}

	result := abs(r)
	expected := Rational{1, 2}

	testing.expect_value(t, result, expected)
}

@(test)
test_exponentiation_of_a_rational_number__raise_a_positive_rational_number_to_a_positive_integer_power :: proc(
	t: ^testing.T,
) {
	r := Rational{1, 2}
	n := 3

	result := exprational(r, n)
	expected := Rational{1, 8}

	testing.expect_value(t, result, expected)
}

@(test)
test_exponentiation_of_a_rational_number__raise_a_negative_rational_number_to_a_positive_integer_power :: proc(
	t: ^testing.T,
) {
	r := Rational{-1, 2}
	n := 3

	result := exprational(r, n)
	expected := Rational{-1, 8}

	testing.expect_value(t, result, expected)
}

@(test)
test_exponentiation_of_a_rational_number__raise_a_positive_rational_number_to_a_negative_integer_power :: proc(
	t: ^testing.T,
) {
	r := Rational{3, 5}
	n := -2

	result := exprational(r, n)
	expected := Rational{25, 9}

	testing.expect_value(t, result, expected)
}

@(test)
test_exponentiation_of_a_rational_number__raise_a_negative_rational_number_to_an_even_negative_integer_power :: proc(
	t: ^testing.T,
) {
	r := Rational{-3, 5}
	n := -2

	result := exprational(r, n)
	expected := Rational{25, 9}

	testing.expect_value(t, result, expected)
}

@(test)
test_exponentiation_of_a_rational_number__raise_a_negative_rational_number_to_an_odd_negative_integer_power :: proc(
	t: ^testing.T,
) {
	r := Rational{-3, 5}
	n := -3

	result := exprational(r, n)
	expected := Rational{-125, 27}

	testing.expect_value(t, result, expected)
}

@(test)
test_exponentiation_of_a_rational_number__raise_zero_to_an_integer_power :: proc(t: ^testing.T) {
	r := Rational{0, 1}
	n := 5

	result := exprational(r, n)
	expected := Rational{0, 1}

	testing.expect_value(t, result, expected)
}

@(test)
test_exponentiation_of_a_rational_number__raise_one_to_an_integer_power :: proc(t: ^testing.T) {
	r := Rational{1, 1}
	n := 4

	result := exprational(r, n)
	expected := Rational{1, 1}

	testing.expect_value(t, result, expected)
}

@(test)
test_exponentiation_of_a_rational_number__raise_a_positive_rational_number_to_the_power_of_zero :: proc(
	t: ^testing.T,
) {
	r := Rational{1, 2}
	n := 0

	result := exprational(r, n)
	expected := Rational{1, 1}

	testing.expect_value(t, result, expected)
}

@(test)
test_exponentiation_of_a_rational_number__raise_a_negative_rational_number_to_the_power_of_zero :: proc(
	t: ^testing.T,
) {
	r := Rational{-1, 2}
	n := 0

	result := exprational(r, n)
	expected := Rational{1, 1}

	testing.expect_value(t, result, expected)
}

@(test)
test_exponentiation_of_a_real_number_to_a_rational_number__raise_a_real_number_to_a_positive_rational_number :: proc(
	t: ^testing.T,
) {
	x := 8.0
	r := Rational{4, 3}

	result := expreal(x, r)
	expected := 16.0

	approximately_equal := math.abs(result - expected) <= 1e-6
	testing.expect(t, approximately_equal)
}

@(test)
test_exponentiation_of_a_real_number_to_a_rational_number__raise_a_real_number_to_a_negative_rational_number :: proc(
	t: ^testing.T,
) {
	x := 9.0
	r := Rational{-1, 2}

	result := expreal(x, r)
	expected := 0.3333333333333333

	approximately_equal := math.abs(result - expected) <= 1e-6
	testing.expect(t, approximately_equal)
}

@(test)
test_exponentiation_of_a_real_number_to_a_rational_number__raise_a_real_number_to_a_zero_rational_number :: proc(
	t: ^testing.T,
) {
	x := 2.0
	r := Rational{0, 1}

	result := expreal(x, r)
	expected := 1.0

	approximately_equal := math.abs(result - expected) <= 1e-6
	testing.expect(t, approximately_equal)
}

@(test)
test_reduction_to_lowest_terms__reduce_a_positive_rational_number_to_lowest_terms :: proc(
	t: ^testing.T,
) {
	r := Rational{2, 4}

	result := reduce(r)
	expected := Rational{1, 2}

	testing.expect_value(t, result, expected)
}

@(test)
test_reduction_to_lowest_terms__reduce_places_the_minus_sign_on_the_numerator :: proc(
	t: ^testing.T,
) {
	r := Rational{3, -4}

	result := reduce(r)
	expected := Rational{-3, 4}

	testing.expect_value(t, result, expected)
}

@(test)
test_reduction_to_lowest_terms__reduce_a_negative_rational_number_to_lowest_terms :: proc(
	t: ^testing.T,
) {
	r := Rational{-4, 6}

	result := reduce(r)
	expected := Rational{-2, 3}

	testing.expect_value(t, result, expected)
}

@(test)
test_reduction_to_lowest_terms__reduce_a_rational_number_with_a_negative_denominator_to_lowest_terms :: proc(
	t: ^testing.T,
) {
	r := Rational{3, -9}

	result := reduce(r)
	expected := Rational{-1, 3}

	testing.expect_value(t, result, expected)
}

@(test)
test_reduction_to_lowest_terms__reduce_zero_to_lowest_terms :: proc(t: ^testing.T) {
	r := Rational{0, 6}

	result := reduce(r)
	expected := Rational{0, 1}

	testing.expect_value(t, result, expected)
}

@(test)
// This test has comments, we will move them
// above the test attribute to make room for the description
test_reduction_to_lowest_terms__reduce_an_integer_to_lowest_terms :: proc(t: ^testing.T) {
	r := Rational{-14, 7}

	result := reduce(r)
	expected := Rational{-2, 1}

	testing.expect_value(t, result, expected)
}

@(test)
/// description = This test comes with a description already
test_reduction_to_lowest_terms__reduce_one_to_lowest_terms :: proc(t: ^testing.T) {
	r := Rational{13, 13}

	result := reduce(r)
	expected := Rational{1, 1}

	testing.expect_value(t, result, expected)
}

@(test)
test_custom_test_not_found_in_canonical_data :: proc(t: ^testing.T) {
	r := Rational{13, 13}

	result := reduce(r)
	expected := Rational{1, 1}

	testing.expect_value(t, result, expected)
}

// The Following tests fails in pangram

@(test)
unique_26_characters_but_not_pangram :: proc(t: ^testing.T) {
	testing.expect(t, !is_pangram("abcdefghijklm ABCDEFGHIJKLM"))
}

@(test)
non_alphanumeric_printable :: proc(t: ^testing.T) {
	testing.expect(t, !is_pangram(" !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"))
}
