package grains

/* Calculate the number of grains on the specified square and return the resulting count, as well
   as the sum of grains on this and all previous squares.
*/
count :: proc(n: int) -> (on_square: u64, total: u64) {
	acc: u64 = 1
	val: u64 = 1

	for i := 2; i <= n; i += 1 {
		val *= 2
		acc += val
	}

	return val, acc
}

// Returns the number of grains on the specified square.
square :: proc(n: int) -> (result: u64, ok: bool) {
	if n < 1 || n > 64 do return 0, false
	c, _ := count(n)
	return c, true
}

// Returns the total number of squares on the board.
total :: proc() -> (result: u64, ok: bool) {
	_, t := count(64)
	return t, true
}
