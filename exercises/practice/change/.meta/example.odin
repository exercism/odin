package change

import "core:slice"

/*
 * We need to find the smallest number of coins to reach the target given a fixed set of coin values.
 *
 * To solve the problem, we basically use a divide and conquer algorithm. For each coin in the set of denomination,
 * we check if there is a solution including this coin and a sub-solution for a target equal to the original target
 * minus the value of the selected coin. If there is more than one sub-solution we picj the one with the smaller set
 * of coins.
 *
 * We explore the sub-solutions recursively (depth-first) until we either find a solution where the target matches
 * a single coin or doesn't have a solution.
 *
 * This technique (depth-first) can still be axhaustive so we use a secondary technique where we store the best
 * solution previously found for a given target. This way, if the same target is encountered in more than one
 * search we only have to compute it once. This is called Memoization, (see https://en.wikipedia.org/wiki/Memoization).
 * 
 */

Error :: enum {
	None,
	No_Solution_With_Given_Coins,
	Target_Cant_Be_Negative,
	Unimplemented,
}

// Keep track of previously found best solutions for a target.
Memoizer :: struct {
	saved_sols: map[int][]int,
}

mem_create :: proc() -> Memoizer {

	return Memoizer{saved_sols = make(map[int][]int)}
}

mem_destroy :: proc(m: ^Memoizer) {

	for _, sol in m.saved_sols {
		delete(sol)
	}
	delete(m.saved_sols)
}

mem_put :: proc(m: ^Memoizer, target: int, solution: []int) {

	// To keep memory mamagement easy, the stored solution
	// is a copy of the input and it is the responsibility of
	// the Memoizer to free it while the caller will free the
	// solution passed in.
	m.saved_sols[target] = slice.clone(solution)
}

mem_get :: proc(m: Memoizer, target: int) -> (solution: []int, ok: bool) {

	solution, ok = m.saved_sols[target]
	// We want to return a clone of the solution to avoid pointer sharing.
	// This makes it easy to manage memory with the mem_get caller responsible
	// to free the returned value while the Memoizer is responsible for
	// clearing the stored solution.
	solution = slice.clone(solution)
	return
}

find_fewest_coins :: proc(coins: []int, target: int) -> ([]int, Error) {

	if target < 0 {
		return nil, .Target_Cant_Be_Negative
	}
	if target == 0 {
		return nil, .None
	}
	if target < coins[0] {
		return nil, .No_Solution_With_Given_Coins
	}
	mem := mem_create()
	defer mem_destroy(&mem)
	sol, ok := min_coins(coins, target, &mem)
	if !ok {
		return nil, .No_Solution_With_Given_Coins
	}
	return sol, .None
}

min_coins :: proc(coins: []int, target: int, mem: ^Memoizer) -> ([]int, bool) {

	if target == 0 {
		return nil, true
	}
	if existing_sol, ok := mem_get(mem^, target); ok {
		return existing_sol, true
	}
	best_sol: [dynamic]int
	for coin in coins {
		if coin <= target {
			sub_sol, ok := min_coins(coins, target - coin, mem)
			defer delete(sub_sol)
			if ok {
				if len(sub_sol) + 1 < len(best_sol) || len(best_sol) == 0 {
					clear(&best_sol)
					append(&best_sol, coin)
					append(&best_sol, ..sub_sol)
				}
			}
		}
	}
	if len(best_sol) == 0 {
		return nil, false
	}
	mem_put(mem, target, best_sol[:])
	return best_sol[:], true
}
