package knapsack

import "core:testing"

@(test)
/// description = no items
test_no_items :: proc(t: ^testing.T) {
	result := maximum_value(100, nil)
	expected: u32 = 0
	testing.expect_value(t, result, expected)
}

@(test)
/// description = one item, too heavy
test_one_item_too_heavy :: proc(t: ^testing.T) {
	items := [?]Item{{weight = 100, value = 1}}
	result := maximum_value(10, items[:])
	expected: u32 = 0
	testing.expect_value(t, result, expected)
}

@(test)
/// description = five items (cannot be greedy by weight)
test_five_items_cannot_be_greedy_by_weight :: proc(t: ^testing.T) {
	items := [?]Item {
		{weight = 2, value = 5},
		{weight = 2, value = 5},
		{weight = 2, value = 5},
		{weight = 2, value = 5},
		{weight = 10, value = 21},
	}
	result := maximum_value(10, items[:])
	expected: u32 = 21
	testing.expect_value(t, result, expected)
}

@(test)
/// description = five items (cannot be greedy by value)
test_five_items_cannot_be_greedy_by_value :: proc(t: ^testing.T) {
	items := [?]Item {
		{weight = 2, value = 20},
		{weight = 2, value = 20},
		{weight = 2, value = 20},
		{weight = 2, value = 20},
		{weight = 10, value = 50},
	}
	result := maximum_value(10, items[:])
	expected: u32 = 80
	testing.expect_value(t, result, expected)
}

@(test)
/// description = example knapsack
test_example_knapsack :: proc(t: ^testing.T) {
	items := [?]Item {
		{weight = 5, value = 10},
		{weight = 4, value = 40},
		{weight = 6, value = 30},
		{weight = 4, value = 50},
	}
	result := maximum_value(10, items[:])
	expected: u32 = 90
	testing.expect_value(t, result, expected)
}

@(test)
/// description = 8 items
test_8_items :: proc(t: ^testing.T) {
	items := [?]Item {
		{weight = 25, value = 350},
		{weight = 35, value = 400},
		{weight = 45, value = 450},
		{weight = 5, value = 20},
		{weight = 25, value = 70},
		{weight = 3, value = 8},
		{weight = 2, value = 5},
		{weight = 2, value = 5},
	}
	result := maximum_value(104, items[:])
	expected: u32 = 900
	testing.expect_value(t, result, expected)
}

@(test)
/// description = 15 items
test_15_items :: proc(t: ^testing.T) {
	items := [?]Item {
		{weight = 70, value = 135},
		{weight = 73, value = 139},
		{weight = 77, value = 149},
		{weight = 80, value = 150},
		{weight = 82, value = 156},
		{weight = 87, value = 163},
		{weight = 90, value = 173},
		{weight = 94, value = 184},
		{weight = 98, value = 192},
		{weight = 106, value = 201},
		{weight = 110, value = 210},
		{weight = 113, value = 214},
		{weight = 115, value = 221},
		{weight = 118, value = 229},
		{weight = 120, value = 240},
	}
	result := maximum_value(750, items[:])
	expected: u32 = 1458
	testing.expect_value(t, result, expected)
}
