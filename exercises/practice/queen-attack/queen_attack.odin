package queen_attack

Error :: enum {
	None,
	InvalidPosition,
	SameSquare,
	Unimplemented,
}

Queen :: [2]int

create :: proc(x, y: int) -> (Queen, Error) {
	// Implement the procedure.
	return Queen{}, .Unimplemented
}

can_attack :: proc(white, black: Queen) -> (bool, Error) {
	// Implement the procedure.
	return false, .Unimplemented
}
