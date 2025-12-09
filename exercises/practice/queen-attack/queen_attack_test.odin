package queen_attack

import "core:testing"

// Test creation of Queens with valid and invalid positions

@(test)
/// description = Test creation of Queens with valid and invalid positions -> queen with a valid position
test_test_creation_of_queens_with_valid_and_invalid_positions__queen_with_a_valid_position :: proc(
	t: ^testing.T,
) {
	queen, e := create(2, 2)
	testing.expect_value(t, queen, [2]int{2, 2})
	testing.expect_value(t, e, Error.None)
}

@(test)
/// description = Test creation of Queens with valid and invalid positions -> queen must have positive row
test_test_creation_of_queens_with_valid_and_invalid_positions__queen_must_have_positive_row :: proc(
	t: ^testing.T,
) {
	_, e := create(-2, 2)
	testing.expect_value(t, e, Error.InvalidPosition)
}

@(test)
/// description = Test creation of Queens with valid and invalid positions -> queen must have row on board
test_test_creation_of_queens_with_valid_and_invalid_positions__queen_must_have_row_on_board :: proc(
	t: ^testing.T,
) {
	_, e := create(8, 4)
	testing.expect_value(t, e, Error.InvalidPosition)
}

@(test)
/// description = Test creation of Queens with valid and invalid positions -> queen must have positive column
test_test_creation_of_queens_with_valid_and_invalid_positions__queen_must_have_positive_column :: proc(
	t: ^testing.T,
) {
	_, e := create(2, -2)
	testing.expect_value(t, e, Error.InvalidPosition)
}

@(test)
/// description = Test creation of Queens with valid and invalid positions -> queen must have column on board
test_test_creation_of_queens_with_valid_and_invalid_positions__queen_must_have_column_on_board :: proc(
	t: ^testing.T,
) {
	_, e := create(4, 8)
	testing.expect_value(t, e, Error.InvalidPosition)
}

// Test the ability of one queen to attack another

@(test)
/// description = Test the ability of one queen to attack another -> cannot attack
test_test_the_ability_of_one_queen_to_attack_another__cannot_attack :: proc(t: ^testing.T) {
	white, ew := create(2, 4)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(6, 6)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, !result)
	testing.expect_value(t, er, Error.None)
}

@(test)
/// description = Test the ability of one queen to attack another -> can attack on same row
test_test_the_ability_of_one_queen_to_attack_another__can_attack_on_same_row :: proc(
	t: ^testing.T,
) {
	white, ew := create(2, 4)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(2, 6)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, result)
	testing.expect_value(t, er, Error.None)
}

@(test)
/// description = Test the ability of one queen to attack another -> can attack on same column
test_test_the_ability_of_one_queen_to_attack_another__can_attack_on_same_column :: proc(
	t: ^testing.T,
) {
	white, ew := create(4, 5)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(2, 5)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, result)
	testing.expect_value(t, er, Error.None)
}

@(test)
/// description = Test the ability of one queen to attack another -> can attack on first diagonal
test_test_the_ability_of_one_queen_to_attack_another__can_attack_on_first_diagonal :: proc(
	t: ^testing.T,
) {
	white, ew := create(2, 2)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(0, 4)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, result, "FAILED")
	testing.expect_value(t, er, Error.None)
}

@(test)
/// description = Test the ability of one queen to attack another -> can attack on second diagonal
test_test_the_ability_of_one_queen_to_attack_another__can_attack_on_second_diagonal :: proc(
	t: ^testing.T,
) {
	white, ew := create(2, 2)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(3, 1)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, result, "FAILED")
	testing.expect_value(t, er, Error.None)
}

@(test)
/// description = Test the ability of one queen to attack another -> can attack on third diagonal
test_test_the_ability_of_one_queen_to_attack_another__can_attack_on_third_diagonal :: proc(
	t: ^testing.T,
) {
	white, ew := create(2, 2)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(1, 1)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, result, "FAILED")
	testing.expect_value(t, er, Error.None)
}

@(test)
/// description = Test the ability of one queen to attack another -> can attack on fourth diagonal
test_test_the_ability_of_one_queen_to_attack_another__can_attack_on_fourth_diagonal :: proc(
	t: ^testing.T,
) {
	white, ew := create(1, 7)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(0, 6)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, result, "FAILED")
	testing.expect_value(t, er, Error.None)
}

@(test)
/// description = Test the ability of one queen to attack another -> can attack on fourth diagonal
test_test_the_ability_of_one_queen_to_attack_another___cannot_attack_if_falling_diagonals_are_only_the_same_when_reflected_across_the_longest_falling_diagonal :: proc(
	t: ^testing.T,
) {
	white, ew := create(4, 1)
	testing.expect_value(t, ew, Error.None)
	black, eb := create(2, 5)
	testing.expect_value(t, eb, Error.None)
	result, er := can_attack(white, black)
	testing.expect(t, !result, "FAILED")
	testing.expect_value(t, er, Error.None)
}
