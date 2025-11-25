package grains

Error :: enum {
	None = 0,
	InvalidSquare,
	Unimplemented,
}

// Returns the number of grains on the specified square.
square :: proc(n: int) -> (u64, Error) {
	// Implement the `square` procedure.
	return 0, .Unimplemented
}

// Returns the total number of squares on the board.
total :: proc() -> (u64, Error) {
	// Implement the `square` procedure.
	return 0, .Unimplemented
}
