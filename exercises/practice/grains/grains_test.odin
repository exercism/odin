/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package grains

import "core:testing"

@(test)
test_returns_the_number_of_grains_on_the_square_grains_on_square_1 :: proc(
	t: ^testing.T,
) {
	c, e := square(1)
	testing.expect_value(t, c, 1)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_returns_the_number_of_grains_on_the_square_grains_on_square_2 :: proc(
	t: ^testing.T,
) {
	c, e := square(2)
	testing.expect_value(t, c, 2)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_returns_the_number_of_grains_on_the_square_grains_on_square_3 :: proc(
	t: ^testing.T,
) {
	c, e := square(3)
	testing.expect_value(t, c, 4)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_returns_the_number_of_grains_on_the_square_grains_on_square_4 :: proc(
	t: ^testing.T,
) {
	c, e := square(4)
	testing.expect_value(t, c, 8)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_returns_the_number_of_grains_on_the_square_grains_on_square_16 :: proc(
	t: ^testing.T,
) {
	c, e := square(16)
	testing.expect_value(t, c, 32_768)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_returns_the_number_of_grains_on_the_square_grains_on_square_32 :: proc(
	t: ^testing.T,
) {
	c, e := square(32)
	testing.expect_value(t, c, 2_147_483_648)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_returns_the_number_of_grains_on_the_square_grains_on_square_64 :: proc(
	t: ^testing.T,
) {
	c, e := square(64)
	testing.expect_value(t, c, 9_223_372_036_854_775_808)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_returns_the_number_of_grains_on_the_square_square_0_raises_an_exception :: proc(
	t: ^testing.T,
) {
	c, e := square(0)
	testing.expect_value(t, c, 0)
	testing.expect_value(t, e, Error.InvalidSquare)
}

// @(test)
test_returns_the_number_of_grains_on_the_square_negative_square_raises_an_exception :: proc(
	t: ^testing.T,
) {
	c, e := square(-1)
	testing.expect_value(t, c, 0)
	testing.expect_value(t, e, Error.InvalidSquare)
}

// @(test)
test_returns_the_number_of_grains_on_the_square_square_greater_than_64_raises_an_exception :: proc(
	t: ^testing.T,
) {
	c, e := square(65)
	testing.expect_value(t, c, 0)
	testing.expect_value(t, e, Error.InvalidSquare)
}

// @(test)
test_returns_the_total_number_of_grains_on_the_board :: proc(t: ^testing.T) {
	c, e := total()
	testing.expect_value(t, c, 18_446_744_073_709_551_615)
	testing.expect_value(t, e, Error.None)
}
