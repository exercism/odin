package binary

// Returns the converted binary input string as an int.
//
// `ok` is false if the input string is not a valid binary number.
convert :: proc(input: string) -> (val: int, ok: bool) {
	for char in input {
		switch char {
		case '0':
			val = val * 2
		case '1':
			val = val * 2 + 1
		case:
			return 0, false
		}
	}

	return val, true
}
