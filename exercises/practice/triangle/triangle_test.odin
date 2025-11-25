package triangle

import "core:testing"

@(test)
test_equilateral_triangle__all_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_equilateral(2, 2, 2)
	testing.expect(t, result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_equilateral_triangle__any_side_is_unequal :: proc(t: ^testing.T) {
	result, err := is_equilateral(2, 3, 2)
	testing.expect(t, !result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_equilateral_triangle__no_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_equilateral(5, 4, 6)
	testing.expect(t, !result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_equilateral_triangle__all_zero_sides_is_not_a_triangle :: proc(t: ^testing.T) {
	_, err := is_equilateral(0, 0, 0)
	testing.expect_value(t, err, Error.Not_A_Triangle)
}

@(test)
test_equilateral_triangle__sides_may_be_floats :: proc(t: ^testing.T) {
	result, err := is_equilateral(0.5, 0.5, 0.5)
	testing.expect(t, result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_isosceles_triangle__last_two_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_isosceles(3, 4, 4)
	testing.expect(t, result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_isosceles_triangle__first_two_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_isosceles(4, 4, 3)
	testing.expect(t, result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_isosceles_triangle__first_and_last_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_isosceles(4, 3, 4)
	testing.expect(t, result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_isosceles_triangle__equilateral_triangles_are_also_isosceles :: proc(t: ^testing.T) {
	result, err := is_isosceles(4, 4, 4)
	testing.expect(t, result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_isosceles_triangle__no_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_isosceles(2, 3, 4)
	testing.expect(t, !result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_isosceles_triangle__first_triangle_inequality_violation :: proc(t: ^testing.T) {
	_, err := is_isosceles(1, 1, 3)
	testing.expect_value(t, err, Error.Not_A_Triangle)
}

@(test)
test_isosceles_triangle__second_triangle_inequality_violation :: proc(t: ^testing.T) {
	_, err := is_isosceles(1, 3, 1)
	testing.expect_value(t, err, Error.Not_A_Triangle)
}

@(test)
test_isosceles_triangle__third_triangle_inequality_violation :: proc(t: ^testing.T) {
	_, err := is_isosceles(3, 1, 1)
	testing.expect_value(t, err, Error.Not_A_Triangle)
}

@(test)
test_isosceles_triangle__sides_may_be_floats :: proc(t: ^testing.T) {
	result, err := is_isosceles(0.5, 0.4, 0.5)
	testing.expect(t, result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_scalene_triangle__no_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_scalene(5, 4, 6)
	testing.expect(t, result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_scalene_triangle__all_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_scalene(4, 4, 4)
	testing.expect(t, !result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_scalene_triangle__first_and_second_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_scalene(4, 4, 3)
	testing.expect(t, !result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_scalene_triangle__first_and_third_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_scalene(3, 4, 3)
	testing.expect(t, !result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_scalene_triangle__second_and_third_sides_are_equal :: proc(t: ^testing.T) {
	result, err := is_scalene(4, 3, 3)
	testing.expect(t, !result)
	testing.expect_value(t, err, Error.None)
}

@(test)
test_scalene_triangle__may_not_violate_triangle_inequality :: proc(t: ^testing.T) {
	_, err := is_scalene(7, 3, 2)
	testing.expect_value(t, err, Error.Not_A_Triangle)
}

@(test)
test_scalene_triangle__sides_may_be_floats :: proc(t: ^testing.T) {
	result, err := is_scalene(0.5, 0.4, 0.6)
	testing.expect(t, result)
	testing.expect_value(t, err, Error.None)
}
