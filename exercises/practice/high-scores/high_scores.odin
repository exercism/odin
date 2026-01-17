package high_scores

// Complete the HighScores data structure.
High_Scores :: struct {}

new_scores :: proc(initial_values: []int) -> High_Scores {
	// Implement this procedure.
	return High_Scores{}
}

destroy_scores :: proc(s: ^High_Scores) {
	// Implement this procedure.
}

scores :: proc(s: High_Scores) -> []int {
	// Implement this procedure.
	return nil
}

latest :: proc(s: High_Scores) -> int {
	// Implement this procedure.
	return 0
}

personal_best :: proc(s: High_Scores) -> int {
	// Implement this procedure.
	return 0
}

personal_top_three :: proc(s: High_Scores) -> []int {
	// Implement this procedure.
	return nil
}
