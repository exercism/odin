/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package hamming

import "core:testing"

@(test)
test_empty_strands :: proc(t: ^testing.T) {
	d, e := distance("", "")
	testing.expect_value(t, d, 0)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_single_letter_identical_strands :: proc(t: ^testing.T) {
	d, e := distance("A", "A")
	testing.expect_value(t, d, 0)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_single_letter_different_strands :: proc(t: ^testing.T) {
	d, e := distance("G", "T")
	testing.expect_value(t, d, 1)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_long_identical_strands :: proc(t: ^testing.T) {
	d, e := distance("GGACTGAAATCTG", "GGACTGAAATCTG")
	testing.expect_value(t, d, 0)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_long_different_strands :: proc(t: ^testing.T) {
	d, e := distance("GGACGGATTCTG", "AGGACGGATTCT")
	testing.expect_value(t, d, 9)
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_disallow_first_strand_longer :: proc(t: ^testing.T) {
	d, e := distance("AATG", "AAA")
	testing.expect_value(t, e, Error.UnequalLengths)
}

// @(test)
test_disallow_second_strand_longer :: proc(t: ^testing.T) {
	d, e := distance("ATA", "AGTG")
	testing.expect_value(t, e, Error.UnequalLengths)
}

// @(test)
test_disallow_left_empty_strand :: proc(t: ^testing.T) {
	d, e := distance("", "G")
	testing.expect_value(t, e, Error.UnequalLengths)
}

// @(test)
test_disallow_right_empty_strand :: proc(t: ^testing.T) {
	d, e := distance("G", "")
	testing.expect_value(t, e, Error.UnequalLengths)
}
