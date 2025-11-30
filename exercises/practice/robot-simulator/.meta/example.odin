package robot_simulator

Heading :: enum {
	North,
	East,
	South,
	West,
}

Position :: [2]int

Robot :: struct {
	pos: Position,
	hd:  Heading,
}

@(private = "file")
steps := [Heading]Position {
	.North = {0, 1},
	.East  = {1, 0},
	.South = {0, -1},
	.West  = {-1, 0},
}

create_robot :: proc(x, y: int, dir: Heading) -> Robot {

	return Robot{pos = Position{x, y}, hd = dir}
}

follow_commands :: proc(r: ^Robot, cmds: string) {

	for cmd in cmds {
		switch cmd {
		case 'R':
			r.hd = Heading((int(r.hd) + 1) %% len(Heading))
		case 'L':
			r.hd = Heading((int(r.hd) - 1) %% len(Heading))
		case 'A':
			r.pos += steps[r.hd]
		}
	}
}
