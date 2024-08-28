package grains

Error :: enum {}// Please inspect the tests to see which error states to enumerate here.


// Returns the number of grains on the specified square.
square :: proc(n: int) -> (u64, Error) {
	#panic("Please implement the `square` procedure.")
}

// Returns the total number of squares on the board.
total :: proc() -> (u64, Error) {
	#panic("Please implement the `total` procedure.")
}
