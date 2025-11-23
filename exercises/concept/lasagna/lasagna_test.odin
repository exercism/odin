package lasagna

import "core:testing"


@(test)
test_oven_time :: proc(t: ^testing.T) {

	expected := 40
	result := OVEN_TIME

	testing.expect_value(t, result, expected)
}

test_remaining_oven_time :: proc(t: ^testing.T) {

	layers := 0
	expected := 25
	result := remaining_oven_time(layers)

	testing.expect_value(t, result, expected)
}

test_preparation_time__one_layer :: proc(t: ^testing.T) {

	layers := 1
	expected := 2
	result := remaining_oven_time(layers)

	testing.expect_value(t, result, expected)

}

test_preparation_time__two_layers :: proc(t: ^testing.T) {

	layers := 2
	expected := 4
	result := remaining_oven_time(layers)

	testing.expect_value(t, result, expected)
}

test_elapsed_time__one_layer :: proc(t: ^testing.T) {

	layers := 1
	minutes_in_oven := 30
	expected := 32
	result := elapsed_time(layers, minutes_in_oven)

	testing.expect_value(t, result, expected)
}

test_elapsed_time__four_layers :: proc(t: ^testing.T) {

	layers := 4
	minutes_in_oven := 8
	expected := 16
	result := elapsed_time(layers, minutes_in_oven)

	testing.expect_value(t, result, expected)
}
