/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package space_age

import "base:intrinsics"
import "core:log"
import "core:testing"

expect_almost :: proc(
	value, expected: $T,
	tolerance := 0.01,
	loc := #caller_location,
) -> bool where intrinsics.type_is_float(T) {
	ok := abs(expected - value) <= tolerance
	if !ok {
		log.errorf("expected %.2f, got %.2f", expected, value, location = loc)
	}
	return ok
}

@(test)
test_age_on_earth :: proc(t: ^testing.T) {
	expect_almost(age(.Earth, 1_000_000_000), 31.69)
}

// @(test)
test_age_on_mercury :: proc(t: ^testing.T) {
	expect_almost(age(.Mercury, 2_134_835_688), 280.88)
}

// @(test)
test_age_on_venus :: proc(t: ^testing.T) {
	expect_almost(age(.Venus, 189_839_836), 9.78)
}

// @(test)
test_age_on_mars :: proc(t: ^testing.T) {
	expect_almost(age(.Mars, 2_129_871_239), 35.88)
}

// @(test)
test_age_on_jupiter :: proc(t: ^testing.T) {
	expect_almost(age(.Jupiter, 901_876_382), 2.41)
}

// @(test)
test_age_on_saturn :: proc(t: ^testing.T) {
	expect_almost(age(.Saturn, 2_000_000_000), 2.15)
}

// @(test)
test_age_on_uranus :: proc(t: ^testing.T) {
	expect_almost(age(.Uranus, 1_210_123_456), 0.46)
}

// @(test)
test_age_on_neptune :: proc(t: ^testing.T) {
	expect_almost(age(.Neptune, 1_821_023_456), 0.35)
}
