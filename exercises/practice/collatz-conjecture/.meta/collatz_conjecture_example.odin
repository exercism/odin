package collatz_conjecture

Error :: enum {
	None,
	IllegalArgument,
}

steps :: proc(start: int) -> (int, Error) {
	if (start <= 0) do return 0, .IllegalArgument

	n := start
	result := 0

	for n > 1 {
		n = n / 2 if n % 2 == 0 else 3 * n + 1
		result += 1
	}

	return result, .None
}
