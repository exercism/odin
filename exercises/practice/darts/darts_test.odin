/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package darts

import "core:testing"

// Return the correct amount earned by a dart's landing position.

@(test)
test_missed_target :: proc(t: ^testing.T) {
	testing.expect_value(t, score(-9, 9), 0)
}

// @(test)
test_on_the_outer_circle :: proc(t: ^testing.T) {
	testing.expect_value(t, score(0, 10), 1)
}

// @(test)
test_on_the_middle_circle :: proc(t: ^testing.T) {
	testing.expect_value(t, score(-5, 0), 5)
}

// @(test)
test_on_the_inner_circle :: proc(t: ^testing.T) {
	testing.expect_value(t, score(0, -1), 10)
}

// @(test)
test_exactly_on_center :: proc(t: ^testing.T) {
	testing.expect_value(t, score(0, 0), 10)
}

// @(test)
test_near_the_center :: proc(t: ^testing.T) {
	testing.expect_value(t, score(-0.1, -0.1), 10)
}

// @(test)
test_just_within_the_inner_circle :: proc(t: ^testing.T) {
	testing.expect_value(t, score(0.7, 0.7), 10)
}

// @(test)
test_just_outside_the_inner_circle :: proc(t: ^testing.T) {
	testing.expect_value(t, score(0.8, -0.8), 5)
}

// @(test)
test_just_within_the_middle_circle :: proc(t: ^testing.T) {
	testing.expect_value(t, score(-3.5, 3.5), 5)
}

// @(test)
test_just_outside_the_middle_circle :: proc(t: ^testing.T) {
	testing.expect_value(t, score(-3.6, -3.6), 1)
}

// @(test)
test_assymetric_between_inner_and_middle :: proc(t: ^testing.T) {
	testing.expect_value(t, score(0.5, -4), 5)
}
