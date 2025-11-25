package two_bucket

Result :: struct {
	moves:        int,
	goal_bucket:  string,
	other_bucket: int,
}

measure :: proc(
	bucket_one: int,
	bucket_two: int,
	goal: int,
	start_bucket: string,
) -> (
	Result,
	bool,
) {
	// Implement this procedure.
	return Result{}, false
}
