package collatz_conjecture

steps :: proc(start: int) -> (result: int, ok: bool) {
	if (start <= 0) do return 0, false

	n := start
	result = 0

	for n > 1 {
		n = n / 2 if n % 2 == 0 else 3 * n + 1
		result += 1
	}

	return result, true
}
