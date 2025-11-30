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
			switch r.hd {
			case .North:
				r.pos.y += 1
			case .East:
				r.pos.x += 1
			case .South:
				r.pos.y -= 1
			case .West:
				r.pos.x -= 1
			}
		}
	}
}
