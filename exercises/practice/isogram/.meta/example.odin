package isogram

is_isogram :: proc(word: string) -> bool {
	seen := bit_set['a' ..= 'z']{}
	DELTA :: 'a' - 'A'
	for c in word {
		switch c {
		case 'a' ..= 'z':
			if c in seen {
				return false
			}
			seen |= {c}
		case 'A' ..= 'Z':
			if c + DELTA in seen {
				return false
			}
			seen |= {c + DELTA}
		case:
		}
	}
	return true
}
