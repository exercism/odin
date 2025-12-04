package yacht

import "core:math"
import "core:slice"

Category :: enum {
	Ones = 1,
	Twos,
	Threes,
	Fours,
	Fives,
	Sixes,
	Full_House,
	Four_Of_A_Kind,
	Little_Straight,
	Big_Straight,
	Yacht,
	Choice,
}

Roll :: [5]int

score :: proc(dice: Roll, category: Category) -> (score: int) {
	dice := dice // shadowing to enable mutability

	switch category {
	case .Ones, .Twos, .Threes, .Fours, .Fives, .Sixes:
		score = score_for(dice[:], int(category))
	case .Full_House:
		score = full_house(dice[:])
	case .Four_Of_A_Kind:
		score = four_of_a_kind(dice[:])
	case .Little_Straight:
		score = straight(dice[:], []int{1, 2, 3, 4, 5})
	case .Big_Straight:
		score = straight(dice[:], []int{2, 3, 4, 5, 6})
	case .Yacht:
		score = yacht(dice[:])
	case .Choice:
		score = math.sum(dice[:])
	}
	return
}

@(private)
score_for :: proc(dice: []int, target: int) -> (score: int) {
	for die in dice {
		if die == target {
			score += die
		}
	}
	return
}

@(private)
yacht :: proc(dice: []int) -> int {
	slice.sort(dice)
	return dice[0] == dice[4] ? 50 : 0
}

@(private)
straight :: proc(dice, wanted: []int) -> int {
	slice.sort(dice)
	return slice.equal(dice, wanted) ? 30 : 0
}

@(private)
four_of_a_kind :: proc(dice: []int) -> int {
	slice.sort(dice)
	if dice[0] == dice[3] || dice[1] == dice[4] {
		return 4 * dice[2]
	}
	return 0
}

@(private)
full_house :: proc(dice: []int) -> int {
	slice.sort(dice)
	// yacht is not a full house
	if dice[0] == dice[4] { return 0 }

	is_full :=
		(dice[0] == dice[1] && dice[2] == dice[4]) || (dice[0] == dice[2] && dice[3] == dice[4])

	return is_full ? math.sum(dice) : 0
}
