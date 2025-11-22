package pangram
is_pangram :: proc(str: string) -> bool {
	vis := 0
	expected := (1 << 26) - 1
	for i in 0 ..< len(str) {
		c := str[i]
		if c >= 'a' && c <= 'z' {
			c -= 'a'
		} else if c >= 'A' && c <= 'Z' {
			c -= 'A'
		} else {
			continue
		}
		vis |= 1 << c
	}
	return vis == expected
}
