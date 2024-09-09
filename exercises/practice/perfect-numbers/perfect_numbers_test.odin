/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package perfect_numbers

import "core:testing"

@(test)
test_smallest_perfect_number :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(6), Classification.Perfect)
}

// @(test)
test_medium_perfect_number :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(28), Classification.Perfect)
}

// @(test)
test_large_perfect_number :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(33550336), Classification.Perfect)
}

// @(test)
test_smallest_abundant_number :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(12), Classification.Abundant)
}

// @(test)
test_medium_abundant_number :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(30), Classification.Abundant)
}

// @(test)
test_large_abundant_number :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(33550335), Classification.Abundant)
}

// @(test)
test_smallest_prime_deficient_number :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(2), Classification.Deficient)
}

// @(test)
test_smallest_non_prime_deficient_number :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(4), Classification.Deficient)
}

// @(test)
test_medium_deficient_number :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(32), Classification.Deficient)
}

// @(test)
test_large_deficient_number :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(33550337), Classification.Deficient)
}

// @(test)
test_1_is_edge_case :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(1), Classification.Deficient)
}

// @(test)
test_zero_is_undefined :: proc(t: ^testing.T) {
	testing.expect_value(t, classify(0), Classification.Undefined)
}
