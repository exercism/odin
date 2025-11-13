package dnd_character

import "core:log"
import "core:math"
import "core:math/rand"
import "core:slice"

Character :: struct {
	strength:     int,
	dexterity:    int,
	constitution: int,
	intelligence: int,
	wisdom:       int,
	charisma:     int,
	hitpoints:    int,
}

modifier :: proc(score: int) -> int {
	return math.floor_div(score - 10, 2)
}

ability :: proc() -> int {
	rolls := [4]int{}
	for i in 0 ..= 3 {
		rolls[i] = rand.int_max(6) + 1
	}
	slice.reverse_sort(rolls[:])
	return rolls[0] + rolls[1] + rolls[2]
}

character :: proc() -> Character {
	c := Character {
		ability(),
		ability(),
		ability(),
		ability(),
		ability(),
		ability(),
		0,
	}
	c.hitpoints = 10 + modifier(c.constitution)
	return c
}
