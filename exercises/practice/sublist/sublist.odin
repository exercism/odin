package sublist

Comparison :: enum {
	Equal,
	Sublist,
	Superlist,
	Unequal,
}

compare :: proc(list_a: []$T, list_b: []T) -> Comparison {
	// Implement this procedure.
	return .Unequal
}
