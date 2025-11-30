package dominoes

Pair :: struct($A, $B: typeid) {
	first:  A,
	second: B,
}

Domino :: Pair(u8, u8)

chain :: proc(dominoes: []Domino) -> ([]Domino, bool) {
	// Implement this procedure.
	return nil, false
}
