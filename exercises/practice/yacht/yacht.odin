package yacht

Category :: enum {
	Ones,
	Twos,
	Threes,
	Fours,
	Fives,
	Sixes,
	Full_House,
	Four_Of_A_Kind,
	Little_Straight,
	Big_Straight,
	Yacht,
	Choice,
}

Roll :: [5]int

score :: proc(dice: Roll, category: Category) -> int {
	// Implement this procedure.
	return -1
}
