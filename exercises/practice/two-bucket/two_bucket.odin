package two_bucket

Result :: struct {
	moves:       int,
	goalBucket:  string,
	otherBucket: int,
}

measure :: proc(
	bucketOne: int,
	bucketTwo: int,
	goal: int,
	startBucket: string,
) -> (
	Result,
	bool,
) {
	#panic("Please implement the  procedure.")
}
