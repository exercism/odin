package sublist

Comparison :: enum {
	Equal,
	Sublist,
	Superlist,
	Unequal,
}

are_slices_equal :: proc(lhs: []$T, rhs: []T) -> bool {
	if len(lhs) != len(rhs) {
		return false
	}
	for e, i in lhs {
		if e != rhs[i] {
			return false
		}
	}
	return true
}

starts_with :: proc(list: []$T, prefix: []T) -> bool {
	if len(list) < len(prefix) {
		return false
	}
	for e, i in prefix {
		if e != list[i] {
			return false
		}
	}
	return true
}

is_sublist :: proc(needle: []$T, haystack: []T) -> bool {
	if len(haystack) == 0 {
		return false
	}
	if starts_with(haystack, needle) {
		return true
	}
	return is_sublist(needle, haystack[1:])
}

compare :: proc(list_a: []$T, list_b: []T) -> Comparison {
	if are_slices_equal(list_a, list_b) {
		return .Equal
	}
	if len(list_a) < len(list_b) && is_sublist(list_a, list_b) {
		return .Sublist
	}
	if len(list_a) > len(list_b) && is_sublist(list_b, list_a) {
		return .Superlist
	}
	return .Unequal
}
