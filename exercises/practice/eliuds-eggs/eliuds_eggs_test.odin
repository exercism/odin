/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package eliuds_eggs

import "core:testing"

@(test)
test_0_eggs :: proc(t: ^testing.T) {
	testing.expect_value(t, egg_count(0), 0)
}

// @(test)
test_1_egg :: proc(t: ^testing.T) {
	testing.expect_value(t, egg_count(16), 1)
}

// @(test)
test_4_eggs :: proc(t: ^testing.T) {
	testing.expect_value(t, egg_count(89), 4)
}

// @(test)
test_13_eggs :: proc(t: ^testing.T) {
	testing.expect_value(t, egg_count(2_000_000_000), 13)
}
