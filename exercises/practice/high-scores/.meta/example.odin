package high_scores

import "core:slice"

HighScores :: struct {
	values: [dynamic]int,
}

new_scores :: proc(initial_values: []int) -> HighScores {

	scores: HighScores
	append(&scores.values, ..initial_values)
	return scores
}

destroy_scores :: proc(s: ^HighScores) {

	delete(s.values)
}

scores :: proc(s: HighScores) -> []int {

	scores := make([]int, len(s.values))
	for i in 0 ..< len(s.values) {
		scores[i] = s.values[i]
	}
	return scores
}

latest :: proc(s: HighScores) -> int {

	if len(s.values) == 0 {
		return 0
	}
	return s.values[len(s.values) - 1]
}

personal_best :: proc(s: HighScores) -> int {

	if len(s.values) == 0 {
		return 0
	}
	best := s.values[0]
	for i in 1 ..< len(s.values) {
		best = max(best, s.values[i])
	}
	return best
}

personal_top_three :: proc(s: HighScores) -> []int {

	// We make a copy of the scores before sorting in
	// place so we don't accidentally reorder the original.
	descending_scores := scores(s)
	slice.sort_by(descending_scores, proc(a, b: int) -> bool {
		return b < a
	})
	limit := min(3, len(descending_scores))
	return descending_scores[0:limit]

}
