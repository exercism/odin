package robot_simulator

Heading :: enum {
	North,
	East,
	South,
	West,
}

Position :: struct {
	x: int,
	y: int,
}

Robot :: struct {
	pos: Position,
	hd:  Heading,
}

create_robot :: proc(x, y: int, dir: Heading) -> Robot {
	// Implement this procedure.
	return Robot{}
}

follow_commands :: proc(r: ^Robot, cmds: string) {
	// Implement this procedure.
}
