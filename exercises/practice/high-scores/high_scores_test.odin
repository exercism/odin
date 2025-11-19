package high_scores

import "core:slice"
import "core:testing"

@(test)
test_scores :: proc(t: ^testing.T) {

	scores_list := [?]int{30, 50, 20, 70}
	expected := [?]int{30, 50, 20, 70}
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	result := scores(score_board)
	defer delete(result)

	testing.expect(t, slice.equal(result, expected[:]))
}

// @(test)
test_latest_score :: proc(t: ^testing.T) {

	scores_list := [?]int{100, 0, 90, 30}
	expected := 30
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	result := latest(score_board)

	testing.expect_value(t, result, expected)
}

// @(test)
test_personal_best :: proc(t: ^testing.T) {

	scores_list := [?]int{40, 100, 70}
	expected := 100
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	result := personal_best(score_board)

	testing.expect_value(t, result, expected)
}

// @(test)
test_personal_top_three_from_a_list_of_scores :: proc(t: ^testing.T) {

	scores_list := [?]int{10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70}
	expected := [?]int{100, 90, 70}
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	result := personal_top_three(score_board)
	defer delete(result)

	testing.expect(t, slice.equal(result, expected[:]))
}

// @(test)
test_personal_top_three_highest_to_lowest :: proc(t: ^testing.T) {

	scores_list := [?]int{20, 10, 30}
	expected := [?]int{30, 20, 10}
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	result := personal_top_three(score_board)
	defer delete(result)

	testing.expect(t, slice.equal(result, expected[:]))
}

// @(test)
test_personal_top_three_when_there_is_a_tie :: proc(t: ^testing.T) {

	scores_list := [?]int{40, 20, 40, 30}
	expected := [?]int{40, 40, 30}
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	result := personal_top_three(score_board)
	defer delete(result)

	testing.expect(t, slice.equal(result, expected[:]))
}

// @(test)
test_personal_top_three_when_there_are_less_than_three :: proc(t: ^testing.T) {

	scores_list := [?]int{30, 70}
	expected := [?]int{70, 30}
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	result := personal_top_three(score_board)
	defer delete(result)

	testing.expect(t, slice.equal(result, expected[:]))
}

// @(test)
test_personal_top_three_when_there_is_only_one :: proc(t: ^testing.T) {

	scores_list := [?]int{40}
	expected := [?]int{40}
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	result := personal_top_three(score_board)
	defer delete(result)

	testing.expect(t, slice.equal(result, expected[:]))
}

// @(test)
test_latest_score_after_personal_top_three :: proc(t: ^testing.T) {

	scores_list := [?]int{70, 50, 20, 30}
	expected := 30
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	dummy_result := personal_top_three(score_board)
	defer delete(dummy_result)
	result := latest(score_board)

	testing.expect_value(t, result, expected)
}

// @(test)
test_scores_after_personal_top_three :: proc(t: ^testing.T) {

	scores_list := [?]int{30, 50, 20, 70}
	expected := [?]int{30, 50, 20, 70}
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	dummy_result := personal_top_three(score_board)
	defer delete(dummy_result)
	result := scores(score_board)
	defer delete(result)

	testing.expect(t, slice.equal(result, expected[:]))
}

// @(test)
test_latest_score_after_personal_best :: proc(t: ^testing.T) {

	scores_list := [?]int{0, 70, 15, 25, 30}
	expected := 30
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	_ = personal_best(score_board)
	result := latest(score_board)

	testing.expect_value(t, result, expected)
}

// @(test)
test_scores_after_personal_best :: proc(t: ^testing.T) {

	scores_list := [?]int{20, 70, 15, 25, 30}
	expected := [?]int{20, 70, 15, 25, 30}
	score_board := new_scores(scores_list[:])
	defer destroy_scores(&score_board)
	_ = personal_best(score_board)
	result := scores(score_board)
	defer delete(result)

	testing.expect(t, slice.equal(result, expected[:]))
}
