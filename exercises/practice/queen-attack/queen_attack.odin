package queen_attack

Error :: enum {} // Please inspect the tests to implement error conditions.

Queen :: [2]int

create :: proc(x, y: int) -> (Queen, Error) {
	#panic("Please implement the `create` procedure.")
}

can_attack :: proc(white, black: Queen) -> (bool, Error) {
	#panic("Please implement the `can_attack` procedure.")
}
