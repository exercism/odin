package change

import "core:fmt"
import "core:path/filepath"
import "core:slice"

Error :: enum {
	None,
	No_Solution_With_Given_Coins,
	Target_Cant_Be_Negative,
	Unimplemented,
}

find_fewest_coins :: proc(coins: []int, target: int) -> ([]int, Error) {
	// Implement this procedure.
	return nil, .Unimplemented
}
