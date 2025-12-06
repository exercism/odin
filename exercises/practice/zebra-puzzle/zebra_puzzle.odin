package zebra_puzzle

import "core:fmt"

// We have 5 houses.
//
// We have 5 groups (color, nationality, animal, cigarette, and drink) or 5 variables.
// Each variable in each group needs to be allocated to a different house.
//
// We have a set of rules describing constraints on some of the variables and houses.
//
// 1. There are five houses.
// 2. The Englishman lives in the red house.
// 3. The Spaniard owns the dog.
// 4. The person in the green house drinks coffee.
// 5. The Ukrainian drinks tea.
// 6. The green house is immediately to the right of the ivory house.
// 7. The snail owner likes to go dancing.
// 8. The person in the yellow house is a painter.
// 9. The person in the middle house drinks milk.
// 10. The Norwegian lives in the first house.
// 11. The person who enjoys reading lives in the house next to the person with the fox.
// 12. The painter's house is next to the house with the horse.
// 13. The person who plays football drinks orange juice.
// 14. The Japanese person plays chess.
// 15. The Norwegian lives next to the blue house.
//
// We will be defining a puzzle as a set of house allocation for each of the 25 variables.
// A variable can be un-allocated (assign to Hose.None) which means the puzzle is incomplete.
//
// We will use a depth first search recursive backtracking algorithm.
// After initializing the puzzle, we will try to assign one of the free variable to a house
// still unassigned to that group, if it passes the constraints then we will (recursively)
// repeat the operation with another un-assigned variable until either all variables are
// assigned (success) or we violate a constraint (failure). In that case we will backtrack
// to the point where we still have a pair (variable, house) that we haven't tried and go back
// down from there.
//
// To speed up the search, we will hard-code the trivial rules in the puzzle setup.
// - Rule #1 "There are five houses"
// - Rule #9 "Milk is drunk in the middle house"
// - Rule #10 "The Norwegian lives in the first house"
//
// We could probably find other optimizations to kickstart the rules (for example once you hard-coded Rule #10,
// it would be easy to hard code Rule #15 "The Norwegian lives next to the blud house" but our algorithm is
// already fast enough.

who_drinks_water :: proc() -> string {

	solved_puzzle, success := solve_puzzle()
	if !success { return "nobody" }

	water_drinker, found := in_the_same_house(solved_puzzle, NATIONALITIES, .Water)
	if !found { return "nobody" }

	return to_string(water_drinker)
}

who_owns_the_zebra :: proc() -> string {

	solved_puzzle, success := solve_puzzle()
	if !success { return "nobody" }

	zebra_owner, found := in_the_same_house(solved_puzzle, NATIONALITIES, .Zebra)
	if !found { return "nobody" }

	return to_string(zebra_owner)
}

// House models the 5 houses of the problem. There is an additional value for when no
// house has been assigned to a variable.
House :: enum u8 {
	None,
	Left,
	Next_To_Left,
	Middle,
	Next_to_Right,
	Right,
}

// Variable models the 25 properties, in group of 5 that we have to assign to the houses,
// one property from each group to each house.
Variable :: enum u8 {
	// House Colors
	Red,
	Green,
	Yellow,
	Ivory,
	Blue,
	// Nationality
	Englishman,
	Spaniard,
	Ukrainian,
	Norwegian,
	Japanese,
	// Pet
	Dog,
	Snail,
	Horse,
	Fox,
	Zebra,
	// Cigarette Brand
	Old_Gold,
	Kools,
	Chesterfields,
	Lucky_Strike,
	Parliaments,
	// Beverage
	Coffee,
	Tea,
	Milk,
	Orange_Juice,
	Water,
}

// Convert a Variable to a string so we can return a solution.
to_string :: proc(v: Variable) -> string {

	return fmt.aprintf("%v", v)
}

// Group represents a set of 5 variables (like nationalities, house colors, ...)
Group :: [5]Variable

// The 5 groups of variables
COLORS :: Group{.Red, .Green, .Yellow, .Ivory, .Blue}
NATIONALITIES :: Group{.Englishman, .Spaniard, .Ukrainian, .Norwegian, .Japanese}
PETS :: Group{.Dog, .Snail, .Horse, .Fox, .Zebra}
CIGARETTES :: Group{.Old_Gold, .Kools, .Chesterfields, .Lucky_Strike, .Parliaments}
DRINKS :: Group{.Coffee, .Tea, .Milk, .Orange_Juice, .Water}

// Retrieve the group assocatied with a Variable
group_of :: proc(v: Variable) -> (group: Group) {
	switch v {
	case .Red, .Green, .Yellow, .Ivory, .Blue:
		group = COLORS
	case .Englishman, .Spaniard, .Ukrainian, .Norwegian, .Japanese:
		group = NATIONALITIES
	case .Dog, .Snail, .Horse, .Fox, .Zebra:
		group = PETS
	case .Old_Gold, .Kools, .Chesterfields, .Lucky_Strike, .Parliaments:
		group = CIGARETTES
	case .Coffee, .Tea, .Milk, .Orange_Juice, .Water:
		group = DRINKS
	}
	return
}

// The puzzle assigns a house to each of the 25 variables.
// As long as there is at least one variable assigned to House.None,
// the problem is not solved.
// Since we are using a backtracking strategy, we will treat a puzzle
// solution as immutable.
Puzzle :: [Variable]House

Error :: union {
	string,
}

// returns the first solution available
// or false if none is found.
solve_puzzle :: proc() -> (Puzzle, bool) {

	initial_pb := setup_initial_puzzle()
	return backtrack(initial_pb, "0")
}

// construct an initial problem.
// It hard-codes rules with obvious solutions (9, 10) to reduce the search space.
setup_initial_puzzle :: proc() -> Puzzle {

	p := Puzzle{}
	// Rule #9 - Milk is drunk in the middle house.
	p = assign(p, .Milk, .Middle)
	// Rule #10 - The Norwegian lives in the first house.
	p = assign(p, .Norwegian, .Left)
	return p
}

// assigns a house location to a free variable.
assign :: proc(p: Puzzle, v: Variable, h: House) -> Puzzle {

	// Sanity check to detect algorithm errors.
	if !is_free(p, v) {
		panic(fmt.aprintf("Attempted to assign variable %v to %v, but already at %v", v, h, p[v]))
	}
	new_p := p
	new_p[v] = h
	return new_p
}

// checks if a variable is unassigned.
is_free :: proc(p: Puzzle, v: Variable) -> bool {

	return p[v] == .None
}

// performs the search by assigning a free variable to a free house for
// the group of the variable and calling Backtrack() recursively. (depth first search).
// If a completed puzzle is found, it is returned. If a solution is impossible we
// backtrack to the brancing point and try another assignment.
backtrack :: proc(p: Puzzle, id: string) -> (Puzzle, bool) {
	v, avail := get_first_free_variable(p)
	if !avail { return p, satifies_constraints(p) }
	freeHouses := free_houses_for_group(p, group_of(v))
	defer delete(freeHouses)
	for h, i in freeHouses {
		augmented_p := assign(p, v, h)
		//new_id := dump(augmented_p, v, h, id, i)
		new_id := ""
		if satifies_constraints(augmented_p) {
			// fmt.println(">>")
			sol, ok := backtrack(augmented_p, new_id)
			if ok { return sol, ok }
		} else {
			// fmt.println("<<")
		}
	}
	return p, false
}

// returns the first free variable for the given puzzle or false
// if all variables are already assigned.
get_first_free_variable :: proc(p: Puzzle) -> (Variable, bool) {

	for v in Variable {
		if is_free(p, v) { return v, true }
	}
	return .Red, false
}

// Checks if a problem passes all the rules.
// Rules hard-coded in the initial problem are not checked.
satifies_constraints :: proc(p: Puzzle) -> bool {

	// Rule #2 - The Englishman lives in the red house.
	if not_in_the_same_house(p, .Englishman, .Red) {
		// fmt.println("    failed: The Englishman lives in the red house.")
		return false
	}

	// Rule #3 - The Spaniard owns the dog.
	if not_in_the_same_house(p, .Spaniard, .Dog) {
		// fmt.println("    failed:  The Spaniard owns the dog.")
		return false
	}

	// Rule #4 - Coffee is drunk in the green house.
	if not_in_the_same_house(p, .Coffee, .Green) {
		// fmt.println("    failed: Coffee is drunk in the green house.")
		return false
	}

	// Rule #5 - The Ukrainian drinks tea.
	if not_in_the_same_house(p, .Ukrainian, .Tea) {
		// fmt.println("    failed: The Ukrainian drinks tea.")
		return false
	}

	// Rule #6 - The green house is immediately to the right of the ivory house.
	if not_to_the_right(p, .Green, .Ivory) {
		// fmt.println("    failed: The green house is immediately to the right of the ivory house.")
		return false
	}

	// Rule #7 - The Old Gold smoker owns snails.
	if not_in_the_same_house(p, .Old_Gold, .Snail) {
		// fmt.println("    failed: The Old Gold smoker owns snails.")
		return false
	}

	// Rule #8 - Kools are smoked in the Yellow house.
	if not_in_the_same_house(p, .Kools, .Yellow) {
		// fmt.println("    failed: Kools are smoked in the Yellow house.")
		return false
	}

	// Rule #9 - Milk is drunk in the middle house.
	// Implemented in setup_initial_problem() - always true

	// Rule #10 - The Norwegian lives in the first house.
	// Implemented in setup_initial_problem() - always true

	// Rule #11 - The man who smokes Chesterfields lives in the house next to the man with the fox.
	if not_next_door(p, .Chesterfields, .Fox) {
		// fmt.println(
		//	"    failed: The man who smokes Chesterfields lives in the house next to the man with the fox.",
		//)
		return false
	}

	// Rule #12 - Kools are smoked in the house next to the house where the horse is kept.
	if not_next_door(p, .Kools, .Horse) {
		//fmt.println(
		//	"    failed: Kools are smoked in the house next to the house where the horse is kept.",
		//)
		return false
	}

	// Rule #13 - The Lucky Strike smoker drinks orange juice.
	if not_in_the_same_house(p, .Lucky_Strike, .Orange_Juice) {
		// fmt.println("    failed: The Lucky Strike smoker drinks orange juice.")
		return false
	}

	// Rule #14 - The Japanese smokes Parliaments.
	if not_in_the_same_house(p, .Japanese, .Parliaments) {
		// fmt.println("    failed: The Japanese smokes Parliaments.")
		return false
	}

	// Rule #15 - The Norwegian lives next to the Blue house.
	if not_next_door(p, .Norwegian, .Blue) {
		// fmt.println("    failed: The Norwegian lives next to the Blue house.")
		return false
	}

	return true
}

// returns the houses that are unallocated for the group.
free_houses_for_group :: proc(p: Puzzle, group: Group) -> []House {

	assigned := [House]bool{}
	for v in group {
		if p[v] != .None { assigned[p[v]] = true }
	}
	res: [dynamic]House
	for h in House {
		if h == .None { continue }
		if !assigned[h] { append(&res, h) }
	}
	return res[:]
}

// checks if the two given variables are assigned.
are_assigned :: proc(p: Puzzle, v1, v2: Variable) -> bool {

	return p[v1] != .None && p[v2] != .None
}

// checks if both variables are assigned and not associated to the same house.
not_in_the_same_house :: proc(p: Puzzle, v1, v2: Variable) -> bool {

	if !are_assigned(p, v1, v2) { return false }
	return p[v1] != p[v2]
}

// checks if both variables are assigned and not associated to neighbor houses.
not_next_door :: proc(p: Puzzle, v1, v2: Variable) -> bool {

	if !are_assigned(p, v1, v2) { return false }
	distance := int(p[v1]) - int(p[v2])
	return abs(distance) != 1

}

// checks if both variables are assigned and the first is not to the right of the second.
not_to_the_right :: proc(p: Puzzle, v1, v2: Variable) -> bool {

	if !are_assigned(p, v1, v2) { return false }
	return int(p[v1]) != int(p[v2]) + 1
}

// returns the variable from the given group that lives in the same house as the variable.
in_the_same_house :: proc(p: Puzzle, group: Group, as: Variable) -> (Variable, bool) {

	for v in group {
		if p[v] == p[as] { return v, true }
	}
	return .Red, false
}

VS := [Variable]rune {
	.Red           = 'R',
	.Green         = 'G',
	.Yellow        = 'Y',
	.Ivory         = 'I',
	.Blue          = 'B',
	.Englishman    = 'E',
	.Spaniard      = 'S',
	.Ukrainian     = 'U',
	.Norwegian     = 'N',
	.Japanese      = 'J',
	.Dog           = 'D',
	.Snail         = 'S',
	.Horse         = 'H',
	.Fox           = 'F',
	.Zebra         = 'Z',
	.Old_Gold      = 'O',
	.Kools         = 'K',
	.Chesterfields = 'C',
	.Lucky_Strike  = 'L',
	.Parliaments   = 'P',
	.Coffee        = 'C',
	.Tea           = 'T',
	.Milk          = 'M',
	.Orange_Juice  = 'O',
	.Water         = 'W',
}
HS := [House]rune {
	.None          = 'x',
	.Left          = 'L',
	.Next_To_Left  = 'l',
	.Middle        = 'M',
	.Next_to_Right = 'r',
	.Right         = 'R',
}

dump :: proc(p: Puzzle, v: Variable, h: House, id: string, subid: int) -> string {

	new_id := fmt.aprintf("%s:%d", id, subid)
	fmt.printf("%s:%d %v -> %v\n", id, subid, v, h)
	for vs, is in Variable {
		fmt.printf("%c ", VS[vs])
		if (is + 1) % 5 == 0 { fmt.print("   ") }
	}
	fmt.println()
	for vh, ih in Variable {
		fmt.printf("%c ", HS[p[vh]])
		if (ih + 1) % 5 == 0 { fmt.print("   ") }
	}
	fmt.println()
	fmt.println()
	return new_id
}
