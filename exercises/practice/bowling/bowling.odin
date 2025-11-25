package bowling

// Populate the Game data structure as needed.
Game :: struct {}

Error :: enum {
	None,
	Game_Over,
	Game_Not_Over,
	Roll_Not_Between_1_And_10,
	Rolls_in_Frame_Exceed_10_Points,
	Unimplemented,
}

roll :: proc(g: ^Game, pins: int) -> Error {
	// Implement the `roll` procedure.
	return .Unimplemented
}

score :: proc(g: Game) -> (int, Error) {
	// Implement the `roll` procedure.
	return 0, .Unimplemented
}
