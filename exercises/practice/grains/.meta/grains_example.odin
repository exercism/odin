package grains

Error :: enum {
	None = 0,
	InvalidSquare,
	NotImplementedError,
}

/* Calculate the number of grains on the specified square and return the resulting count, as well
   as the sum of grains on this and all previous squares.
*/
count :: proc(n: int) -> (u64, u64) {
	acc: u64 = 1
	val: u64 = 1

	for i := 2; i <= n; i += 1 {
		val *= 2
		acc += val
	}

	return val, acc
}

// Returns the number of grains on the specified square.
square :: proc(n: int) -> (u64, Error) {
	if n < 1 || n > 64 do return 0, .InvalidSquare
	c, _ := count(n)
	return c, .None
}

// Returns the total number of squares on the board.
total :: proc() -> u64 {
	_, t := count(64)
	return t
}
