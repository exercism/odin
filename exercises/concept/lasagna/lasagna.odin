package lasagna

// Define the constant `OVEN_TIME` representing the expected baking time in minutes.
OVEN_TIME :: 0

// Define the constant `LAYER_PREP_TIME` representing the expected preparation time
// per layer in minutes.
LAYER_PREP_TIME :: 0

// procedure returning the remaining minutes based on the `actual` minutes already in the oven.
remaining_oven_time :: proc(actual_minutes_in_oven: int) -> int {
	// Implement this procedure.
	return 0
}

// procedure calculating the time needed to prepare the lasagna based on the amount of layers.
preparation_time :: proc(number_of_layers: int) -> int {
	// Implement this procedure.
	return 0
}

// procedure calculating the total time needed to create and bake a lasagna.
elapsed_time :: proc(number_of_layers, actual_minutes_in_oven: int) -> int {
	// Implement this procedure.
	return 0
}
