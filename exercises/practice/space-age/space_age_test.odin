/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package space_age

import "core:testing"

default_tolerance :: 0.01

loosely_equals :: proc(x, y: f64, tolerance := default_tolerance) -> bool {
	return abs(x - y) <= tolerance
}

@(test)
test_age_on_earth :: proc(t: ^testing.T) {
	testing.expect(t, loosely_equals(age(.Earth, 1_000_000_000), 31.69))
}
