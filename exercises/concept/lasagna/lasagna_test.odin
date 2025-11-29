package lasagna

import "core:testing"

@(test)
/// description = Define the expected time spent in the oven
/// task = 1
test_oven_time :: proc(t: ^testing.T) {

	expected := 40
	result := OVEN_TIME

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Define the time required to prepare a layer
/// task = 2
test_layer_prep_time :: proc(t: ^testing.T) {

	expected := 2
	result := LAYER_PREP_TIME

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Calculate the remaining oven time.
// task = 3
test_remaining_oven_time :: proc(t: ^testing.T) {

	time_in_oven := 15
	expected := 25
	result := remaining_oven_time(time_in_oven)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Calculate the preparation time in minutes
/// task = 4
test_preparation_time__one_layer :: proc(t: ^testing.T) {

	layers := 1
	expected := 2
	result := preparation_time(layers)

	testing.expect_value(t, result, expected)

}

@(test)
/// description = Calculate the total working time in minutes
/// task = 5
test_preparation_time__two_layers :: proc(t: ^testing.T) {

	layers := 2
	expected := 4
	result := preparation_time(layers)

	testing.expect_value(t, result, expected)
}

@(test)
test_elapsed_time__one_layer :: proc(t: ^testing.T) {

	layers := 1
	minutes_in_oven := 30
	expected := 32
	result := elapsed_time(layers, minutes_in_oven)

	testing.expect_value(t, result, expected)
}

@(test)
test_elapsed_time__four_layers :: proc(t: ^testing.T) {

	layers := 4
	minutes_in_oven := 8
	expected := 16
	result := elapsed_time(layers, minutes_in_oven)

	testing.expect_value(t, result, expected)
}
