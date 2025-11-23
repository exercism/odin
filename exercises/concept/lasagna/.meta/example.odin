package lasagna

// Constant representing the expected baking time in minutes.
OVEN_TIME :: 40

// procedure returning the remaining minutes based on the `actual` minutes already in the oven.
remaining_oven_time :: proc(actual_minutes_in_oven: int) -> int {

	return OVEN_TIME - actual_minutes_in_oven
}

// procedure calculating the time needed to prepare the lasagna based on the amount of layers.
preparation_time :: proc(number_of_layers: int) -> int {

	return number_of_layers * 2
}

// procedure calculating the total time needed to create and bake a lasagna.
elapsed_time :: proc(number_of_layers, actual_minutes_in_oven: int) -> int {

	return preparation_time(number_of_layers) + actual_minutes_in_oven
}
