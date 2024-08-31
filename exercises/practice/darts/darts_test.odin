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
