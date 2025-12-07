package change

import "core:fmt"
import "core:testing"

/* ------------------------------------------------------------
 * A helper procedure to enable more helpful test failure output.
 * Stringify the slices and compare the strings.
 * If they don't match, the user will see the values.
 */
expect_slices_match :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {
	result := fmt.aprintf("%v", actual) // this varname shows up in the test output
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str)
}

@(test)
/// description = change for 1 cent
test_change_for_1_cent :: proc(t: ^testing.T) {

	coins := [?]int{1, 5, 10, 25}
	target := 1
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	expected := [?]int{1}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = single coin change
test_single_coin_change :: proc(t: ^testing.T) {

	coins := [?]int{1, 5, 10, 25, 100}
	target := 25
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	expected := [?]int{25}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = multiple coin change
test_multiple_coin_change :: proc(t: ^testing.T) {

	coins := [?]int{1, 5, 10, 25, 100}
	target := 15
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	expected := [?]int{5, 10}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = change with Lilliputian Coins
test_change_with_lilliputian_coins :: proc(t: ^testing.T) {

	coins := [?]int{1, 4, 15, 20, 50}
	target := 23
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	expected := [?]int{4, 4, 15}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = change with Lower Elbonia Coins
test_change_with_lower_elbonia_coins :: proc(t: ^testing.T) {

	coins := [?]int{1, 5, 10, 21, 25}
	target := 63
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	expected := [?]int{21, 21, 21}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = large target values
test_large_target_values :: proc(t: ^testing.T) {

	coins := [?]int{1, 2, 5, 10, 20, 50, 100}
	target := 999
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	expected := [?]int{2, 2, 5, 20, 20, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = possible change without unit coins available
test_possible_change_without_unit_coins_available :: proc(t: ^testing.T) {

	coins := [?]int{2, 5, 10, 20, 50}
	target := 21
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	expected := [?]int{2, 2, 2, 5, 10}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = another possible change without unit coins available
test_another_possible_change_without_unit_coins_available :: proc(t: ^testing.T) {

	coins := [?]int{4, 5}
	target := 27
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	expected := [?]int{4, 4, 4, 5, 5, 5}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = a greedy approach is not optimal
test_a_greedy_approach_is_not_optimal :: proc(t: ^testing.T) {

	coins := [?]int{1, 10, 11}
	target := 20
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	expected := [?]int{10, 10}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = no coins make 0 change
test_no_coins_make_0_change :: proc(t: ^testing.T) {

	coins := [?]int{1, 5, 10, 21, 25}
	target := 0
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	expected := [?]int{}

	testing.expect_value(t, error, Error.None)
	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = error testing for change smaller than the smallest of coins
test_error_testing_for_change_smaller_than_the_smallest_of_coins :: proc(t: ^testing.T) {

	coins := [?]int{5, 10}
	target := 3
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)

	testing.expect_value(t, error, Error.No_Solution_With_Given_Coins)
}

@(test)
/// description = error if no combination can add up to target
test_error_if_no_combination_can_add_up_to_target :: proc(t: ^testing.T) {

	coins := [?]int{5, 10}
	target := 94
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)
	testing.expect_value(t, error, Error.No_Solution_With_Given_Coins)
}

@(test)
/// description = cannot find negative change values
test_cannot_find_negative_change_values :: proc(t: ^testing.T) {

	coins := [?]int{1, 2, 5}
	target := -5
	result, error := find_fewest_coins(coins[:], target)
	defer delete(result)

	testing.expect_value(t, error, Error.Target_Cant_Be_Negative)
}
