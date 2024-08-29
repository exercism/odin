/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package collatz_conjecture

import "core:testing"

@(test)
test_zero_steps_for_one :: proc(t: ^testing.T) {
	s, e := steps(1)
	testing.expect_value(t, s, 0)
	testing.expect_value(t, e, Error.None)
}

@(test)
test_divide_if_even :: proc(t: ^testing.T) {
	s, e := steps(16)
	testing.expect_value(t, s, 4)
	testing.expect_value(t, e, Error.None)
}

@(test)
test_even_and_odd_steps :: proc(t: ^testing.T) {
	s, e := steps(12)
	testing.expect_value(t, s, 9)
	testing.expect_value(t, e, Error.None)
}

@(test)
test_large_number_of_even_and_odd_steps :: proc(t: ^testing.T) {
	s, e := steps(1_000_000)
	testing.expect_value(t, s, 152)
	testing.expect_value(t, e, Error.None)
}

@(test)
test_zero_is_an_error :: proc(t: ^testing.T) {
	s, e := steps(0)
	testing.expect_value(t, s, 0)
	testing.expect_value(t, e, Error.IllegalArgument)
}
