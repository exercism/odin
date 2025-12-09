package queen_attack

Error :: enum {
	None,
	InvalidPosition,
	SameSquare,
	Unimplemented,
}

Queen :: [2]int

create :: proc(x, y: int) -> (Queen, Error) {
	if x < 0 || x >= 8 || y < 0 || y >= 8 { return {0, 0}, .InvalidPosition }
	return {x, y}, .None
}

can_attack :: proc(white, black: Queen) -> (bool, Error) {
	d := white - black
	if d.x == 0 && d.y == 0 { return false, .SameSquare }
	return abs(d.x) == abs(d.y) || d.x == 0 || d.y == 0, .None
}
