package yacht

import "core:testing"

@(test)
/// description = Yacht
test_yacht :: proc(t: ^testing.T) {
	result := score(Roll{5, 5, 5, 5, 5}, Category.Yacht)
	expected := 50

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Not Yacht
test_not_yacht :: proc(t: ^testing.T) {
	result := score(Roll{1, 3, 3, 2, 5}, Category.Yacht)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Ones
test_ones :: proc(t: ^testing.T) {
	result := score(Roll{1, 1, 1, 3, 5}, Category.Ones)
	expected := 3

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Ones, out of order
test_ones_out_of_order :: proc(t: ^testing.T) {
	result := score(Roll{3, 1, 1, 5, 1}, Category.Ones)
	expected := 3

	testing.expect_value(t, result, expected)
}

@(test)
/// description = No ones
test_no_ones :: proc(t: ^testing.T) {
	result := score(Roll{4, 3, 6, 5, 5}, Category.Ones)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Twos
test_twos :: proc(t: ^testing.T) {
	result := score(Roll{2, 3, 4, 5, 6}, Category.Twos)
	expected := 2

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Fours
test_fours :: proc(t: ^testing.T) {
	result := score(Roll{1, 4, 1, 4, 1}, Category.Fours)
	expected := 8

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Yacht counted as threes
test_yacht_counted_as_threes :: proc(t: ^testing.T) {
	result := score(Roll{3, 3, 3, 3, 3}, Category.Threes)
	expected := 15

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Yacht of 3s counted as fives
test_yacht_of_3s_counted_as_fives :: proc(t: ^testing.T) {
	result := score(Roll{3, 3, 3, 3, 3}, Category.Fives)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Fives
test_fives :: proc(t: ^testing.T) {
	result := score(Roll{1, 5, 3, 5, 3}, Category.Fives)
	expected := 10

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Sixes
test_sixes :: proc(t: ^testing.T) {
	result := score(Roll{2, 3, 4, 5, 6}, Category.Sixes)
	expected := 6

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Full house two small, three big
test_full_house_two_small_three_big :: proc(t: ^testing.T) {
	result := score(Roll{2, 2, 4, 4, 4}, Category.Full_House)
	expected := 16

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Full house three small, two big
test_full_house_three_small_two_big :: proc(t: ^testing.T) {
	result := score(Roll{5, 3, 3, 5, 3}, Category.Full_House)
	expected := 19

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Two pair is not a full house
test_two_pair_is_not_a_full_house :: proc(t: ^testing.T) {
	result := score(Roll{2, 2, 4, 4, 5}, Category.Full_House)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Four of a kind is not a full house
test_four_of_a_kind_is_not_a_full_house :: proc(t: ^testing.T) {
	result := score(Roll{1, 4, 4, 4, 4}, Category.Full_House)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Yacht is not a full house
test_yacht_is_not_a_full_house :: proc(t: ^testing.T) {
	result := score(Roll{2, 2, 2, 2, 2}, Category.Full_House)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Four of a Kind
test_four_of_a_kind :: proc(t: ^testing.T) {
	result := score(Roll{6, 6, 4, 6, 6}, Category.Four_Of_A_Kind)
	expected := 24

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Yacht can be scored as Four of a Kind
test_yacht_can_be_scored_as_four_of_a_kind :: proc(t: ^testing.T) {
	result := score(Roll{3, 3, 3, 3, 3}, Category.Four_Of_A_Kind)
	expected := 12

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Full house is not Four of a Kind
test_full_house_is_not_four_of_a_kind :: proc(t: ^testing.T) {
	result := score(Roll{3, 3, 3, 5, 5}, Category.Four_Of_A_Kind)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Little Straight
test_little_straight :: proc(t: ^testing.T) {
	result := score(Roll{3, 5, 4, 1, 2}, Category.Little_Straight)
	expected := 30

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Little Straight as Big Straight
test_little_straight_as_big_straight :: proc(t: ^testing.T) {
	result := score(Roll{1, 2, 3, 4, 5}, Category.Big_Straight)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Four in order but not a little straight
test_four_in_order_but_not_a_little_straight :: proc(t: ^testing.T) {
	result := score(Roll{1, 1, 2, 3, 4}, Category.Little_Straight)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = No pairs but not a little straight
test_no_pairs_but_not_a_little_straight :: proc(t: ^testing.T) {
	result := score(Roll{1, 2, 3, 4, 6}, Category.Little_Straight)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Minimum is 1, maximum is 5, but not a little straight
test_minimum_is_1_maximum_is_5_but_not_a_little_straight :: proc(t: ^testing.T) {
	result := score(Roll{1, 1, 3, 4, 5}, Category.Little_Straight)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Big Straight
test_big_straight :: proc(t: ^testing.T) {
	result := score(Roll{4, 6, 2, 5, 3}, Category.Big_Straight)
	expected := 30

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Big Straight as little straight
test_big_straight_as_little_straight :: proc(t: ^testing.T) {
	result := score(Roll{6, 5, 4, 3, 2}, Category.Little_Straight)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = No pairs but not a big straight
test_no_pairs_but_not_a_big_straight :: proc(t: ^testing.T) {
	result := score(Roll{6, 5, 4, 3, 1}, Category.Big_Straight)
	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Choice
test_choice :: proc(t: ^testing.T) {
	result := score(Roll{3, 3, 5, 6, 6}, Category.Choice)
	expected := 23

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Yacht as choice
test_yacht_as_choice :: proc(t: ^testing.T) {
	result := score(Roll{2, 2, 2, 2, 2}, Category.Choice)
	expected := 10

	testing.expect_value(t, result, expected)
}
