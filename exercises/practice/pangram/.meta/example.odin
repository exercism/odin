package pangram

is_pangram :: proc(str: string) -> bool {
	Alphabet :: bit_set['a' ..= 'z']
	expected := Alphabet {
		'a',
		'b',
		'c',
		'd',
		'e',
		'f',
		'g',
		'h',
		'i',
		'j',
		'k',
		'l',
		'm',
		'n',
		'o',
		'p',
		'q',
		'r',
		's',
		't',
		'u',
		'v',
		'w',
		'x',
		'y',
		'z',
	}
	vis: Alphabet
	for c in str {
		if c >= 'a' && c <= 'z' {
			vis += {c}
		} else if c >= 'A' && c <= 'Z' {
			vis += {c - 'A' + 'a'}
		} else {
			continue
		}
	}
	return vis == expected
}
