/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package queen_attack

import "core:testing"

// Test creation of Queens with valid and invalid positions

@(test)
test_queen_with_a_valid_position :: proc(t: ^testing.T) {
	queen, e := create(2, 2)
	testing.expect_value(t, queen, [2]int{2, 2})
	testing.expect_value(t, e, Error.None)
}

// @(test)
test_queen_must_have_positive_row :: proc(t: ^testing.T) {
	queen, e := create(-2, 2)
	testing.expect_value(t, e, Error.InvalidPosition)
}

// @(test)
test_queen_must_have_row_on_board :: proc(t: ^testing.T) {
	queen, e := create(8, 4)
	testing.expect_value(t, e, Error.InvalidPosition)
}

// @(test)
test_queen_must_have_positive_column :: proc(t: ^testing.T) {
	queen, e := create(2, -2)
	testing.expect_value(t, e, Error.InvalidPosition)
}

// @(test)
test_queen_must_have_column_on_board :: proc(t: ^testing.T) {
	queen, e := create(4, 8)
	testing.expect_value(t, e, Error.InvalidPosition)
}

// Test the ability of one queen to attack another

// @(test)
test_cannot_attack :: proc(t: ^testing.T) {
	white, ew := create(2, 4)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(6, 6)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, !result)
	testing.expect_value(t, er, Error.None)
}

// @(test)
test_can_attack_on_same_row :: proc(t: ^testing.T) {
	white, ew := create(2, 4)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(2, 6)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, result)
	testing.expect_value(t, er, Error.None)
}

// @(test)
test_can_attack_on_same_column :: proc(t: ^testing.T) {
	white, ew := create(4, 5)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(2, 5)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, result)
	testing.expect_value(t, er, Error.None)
}

// @(test)
test_can_attack_on_first_diagonal :: proc(t: ^testing.T) {
	white, ew := create(2, 2)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(0, 4)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, result, "FAILED")
	testing.expect_value(t, er, Error.None)
}

// @(test)
test_can_attack_on_second_diagonal :: proc(t: ^testing.T) {
	white, ew := create(2, 2)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(3, 1)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, result, "FAILED")
	testing.expect_value(t, er, Error.None)
}
