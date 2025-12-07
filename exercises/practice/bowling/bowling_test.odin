package bowling

import "core:fmt"
import "core:testing"

apply_previous_rolls :: proc(t: ^testing.T, g: ^Game, rolls: []int, loc := #caller_location) {

	for pins, index in rolls {
		if err := roll(g, pins); err != .None {
			err_msg := fmt.aprintf(
				"Unexpected error while applying previous roll #%d of %d pins: %v",
				index,
				pins,
				err,
			)
			testing.fail_now(t, err_msg, loc = loc)
		}
	}
}

@(test)
/// description = should be able to score a game with all zeros
test_should_be_able_to_score_a_game_with_all_zeros :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 0

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = should be able to score a game with no strikes or spares
test_should_be_able_to_score_a_game_with_no_strikes_or_spares :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 90

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = a spare followed by zeros is worth ten points
test_a_spare_followed_by_zeros_is_worth_ten_points :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 10

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = points scored in the roll after a spare are counted twice
test_points_scored_in_the_roll_after_a_spare_are_counted_twice :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 16

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = consecutive spares each get a one roll bonus
test_consecutive_spares_each_get_a_one_roll_bonus :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 31

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = a spare in the last frame gets a one roll bonus that is counted once
test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 17

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = a strike earns ten points in a frame with a single roll
test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 10

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = points scored in the two rolls after a strike are counted twice as a bonus
test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus :: proc(
	t: ^testing.T,
) {

	game := new_game()
	rolls := [?]int{10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 26

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = consecutive strikes each get the two roll bonus
test_consecutive_strikes_each_get_the_two_roll_bonus :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 81

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = a strike in the last frame gets a two roll bonus that is counted once
test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 18

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = rolling a spare with the two roll bonus does not get a bonus roll
test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 20

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = strikes with the two roll bonus do not get bonus rolls
test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 30

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = last two strikes followed by only last bonus with non strike points
test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 31

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = a strike with the one roll bonus after a spare in the last frame does not get a bonus
test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus :: proc(
	t: ^testing.T,
) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 20

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = all strikes is a perfect game
test_all_strikes_is_a_perfect_game :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 300

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = rolls cannot score negative points
test_rolls_cannot_score_negative_points :: proc(t: ^testing.T) {

	game := new_game()
	error := roll(&game, -1)

	testing.expect_value(t, error, Error.Roll_Not_Between_1_And_10)
}

@(test)
/// description = a roll cannot score more than 10 points
test_a_roll_cannot_score_more_than_10_points :: proc(t: ^testing.T) {

	game := new_game()
	error := roll(&game, 11)

	testing.expect_value(t, error, Error.Roll_Not_Between_1_And_10)
}

@(test)
/// description = two rolls in a frame cannot score more than 10 points
test_two_rolls_in_a_frame_cannot_score_more_than_10_points :: proc(t: ^testing.T) {

	game := new_game()
	error := roll(&game, 5)
	testing.expect_value(t, error, Error.None)
	error = roll(&game, 6)

	testing.expect_value(t, error, Error.Rolls_in_Frame_Exceed_10_Points)
}

@(test)
/// description = bonus roll after a strike in the last frame cannot score more than 10 points
test_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points :: proc(
	t: ^testing.T,
) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10}
	apply_previous_rolls(t, &game, rolls[:])
	error := roll(&game, 11)

	testing.expect_value(t, error, Error.Roll_Not_Between_1_And_10)
}

@(test)
/// description = two bonus rolls after a strike in the last frame cannot score more than 10 points
test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points :: proc(
	t: ^testing.T,
) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5}
	apply_previous_rolls(t, &game, rolls[:])
	error := roll(&game, 6)

	testing.expect_value(t, error, Error.Rolls_in_Frame_Exceed_10_Points)
}

@(test)
/// description = two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike
test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike :: proc(
	t: ^testing.T,
) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6}
	apply_previous_rolls(t, &game, rolls[:])
	result, error := score(game)
	expected := 26

	testing.expect_value(t, error, Error.None)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike
test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike :: proc(
	t: ^testing.T,
) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6}
	apply_previous_rolls(t, &game, rolls[:])
	error := roll(&game, 10)

	testing.expect_value(t, error, Error.Rolls_in_Frame_Exceed_10_Points)
}

@(test)
/// description = second bonus roll after a strike in the last frame cannot score more than 10 points
test_second_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points :: proc(
	t: ^testing.T,
) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10}
	apply_previous_rolls(t, &game, rolls[:])
	error := roll(&game, 11)

	testing.expect_value(t, error, Error.Roll_Not_Between_1_And_10)
}

@(test)
/// description = an unstarted game cannot be scored
test_an_unstarted_game_cannot_be_scored :: proc(t: ^testing.T) {

	game := new_game()
	_, error := score(game)

	testing.expect_value(t, error, Error.Game_Not_Over)
}

@(test)
/// description = an incomplete game cannot be scored
test_an_incomplete_game_cannot_be_scored :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{0, 0}
	apply_previous_rolls(t, &game, rolls[:])
	_, error := score(game)

	testing.expect_value(t, error, Error.Game_Not_Over)
}

@(test)
/// description = cannot roll if game already has ten frames
test_cannot_roll_if_game_already_has_ten_frames :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	apply_previous_rolls(t, &game, rolls[:])
	error := roll(&game, 0)

	testing.expect_value(t, error, Error.Game_Over)
}

@(test)
/// description = bonus rolls for a strike in the last frame must be rolled before score can be calculated
test_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated :: proc(
	t: ^testing.T,
) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10}
	apply_previous_rolls(t, &game, rolls[:])
	_, error := score(game)

	testing.expect_value(t, error, Error.Game_Not_Over)
}

@(test)
/// description = both bonus rolls for a strike in the last frame must be rolled before score can be calculated
test_both_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated :: proc(
	t: ^testing.T,
) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10}
	apply_previous_rolls(t, &game, rolls[:])
	_, error := score(game)

	testing.expect_value(t, error, Error.Game_Not_Over)
}

@(test)
/// description = bonus roll for a spare in the last frame must be rolled before score can be calculated
test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated :: proc(
	t: ^testing.T,
) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3}
	apply_previous_rolls(t, &game, rolls[:])
	_, error := score(game)

	testing.expect_value(t, error, Error.Game_Not_Over)
}

@(test)
/// description = cannot roll after bonus roll for spare
test_cannot_roll_after_bonus_roll_for_spare :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2}
	apply_previous_rolls(t, &game, rolls[:])
	error := roll(&game, 2)

	testing.expect_value(t, error, Error.Game_Over)
}

@(test)
/// description = cannot roll after bonus rolls for strike
test_cannot_roll_after_bonus_rolls_for_strike :: proc(t: ^testing.T) {

	game := new_game()
	rolls := [?]int{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2}
	apply_previous_rolls(t, &game, rolls[:])
	error := roll(&game, 2)

	testing.expect_value(t, error, Error.Game_Over)
}
