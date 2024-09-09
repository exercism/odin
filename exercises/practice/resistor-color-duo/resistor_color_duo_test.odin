/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package resistor_color_duo

import "core:testing"

@(test)
test_brown_and_black :: proc(t: ^testing.T) {
	c, e := value({.Brown, .Black})
	testing.expect_value(t, c, 10)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_blue_and_grey :: proc(t: ^testing.T) {
	c, e := value({.Blue, .Grey})
	testing.expect_value(t, c, 68)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_yellow_and_violet :: proc(t: ^testing.T) {
	c, e := value({.Yellow, .Violet})
	testing.expect_value(t, c, 47)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_white_and_red :: proc(t: ^testing.T) {
	c, e := value({.White, .Red})
	testing.expect_value(t, c, 92)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_orange_and_orange :: proc(t: ^testing.T) {
	c, e := value({.Orange, .Orange})
	testing.expect_value(t, c, 33)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_ignore_additional_colors :: proc(t: ^testing.T) {
	c, e := value({.Green, .Brown, .Orange})
	testing.expect_value(t, c, 51)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_black_and_brown_one_digit :: proc(t: ^testing.T) {
	c, e := value({.Black, .Brown})
	testing.expect_value(t, c, 1)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_one_color_is_an_error :: proc(t: ^testing.T) {
	c, e := value({.Violet})
	testing.expect_value(t, e, Error.TooFewColors)
}

// @(test)
test_empty_slice_is_an_error :: proc(t: ^testing.T) {
	c, e := value({})
	testing.expect_value(t, e, Error.TooFewColors)
}
