package high_scores

import "core:slice"

// Note: We could have implemented High_Scores ust as `High_Scores :: [dynamic]int`
// or even High_Scores :: []int` but this doesn't seem to match the spirit of the
// exercise as implemented in other tracks like Javascript where a real
// implementation would have additional methods/functions such as `record_new_score()`.

High_Scores :: struct {
	values: [dynamic]int,
}

new_scores :: proc(initial_values: []int) -> High_Scores {

	scores: High_Scores
	append(&scores.values, ..initial_values)
	return scores
}

destroy_scores :: proc(s: ^High_Scores) {

	delete(s.values)
}

scores :: proc(s: High_Scores) -> []int {

	scores := make([]int, len(s.values))
	for i in 0 ..< len(s.values) {
		scores[i] = s.values[i]
	}
	return scores
}

latest :: proc(s: High_Scores) -> int {

	if len(s.values) == 0 {
		return 0
	}
	return s.values[len(s.values) - 1]
}

personal_best :: proc(s: High_Scores) -> int {

	if len(s.values) == 0 {
		return 0
	}
	best := s.values[0]
	for i in 1 ..< len(s.values) {
		best = max(best, s.values[i])
	}
	return best
}

personal_top_three :: proc(s: High_Scores) -> []int {

	// We make a copy of the scores before sorting in
	// place so we don't accidentally reorder the original.
	descending_scores := scores(s)
	slice.sort_by(descending_scores, proc(a, b: int) -> bool {
		return b < a
	})
	limit := min(3, len(descending_scores))
	return descending_scores[0:limit]

}
