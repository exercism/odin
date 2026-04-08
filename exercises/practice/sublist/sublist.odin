package sublist

Comparison :: enum {
	Unimplemented,
	Equal,
	Sublist,
	Superlist,
	Unequal,
}

compare :: proc(list_a: []$T, list_b: []T) -> Comparison {
	// Implement this procedure.
	return .Unimplemented
}
