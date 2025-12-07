package binary_search

find :: proc(haysack: []$T, needle: T) -> (index: int, found: bool) #optional_ok {
	l, r := 0, len(haysack)
	for l < r {
		m := (l + r) / 2
		if haysack[m] >= needle {
			r = m
		} else {
			l = m + 1
		}
	}
	return l, l < len(haysack) && haysack[l] == needle
}

// std provide a similar implementation
// import "core:slice"
// find :: proc(haysack: []$T, needle: T) -> (index: int, found: bool) #optional_ok {
// 	return slice.binary_search(haysack, needle)
// }
