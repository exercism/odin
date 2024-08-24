package difference_of_squares

import "core:testing"

@(test)
test_square_of_sum_1 :: proc(t: ^testing.T) {
	testing.expect_value(t, square_of_sum(1), 1)
}

@(test)
test_square_of_sum_5 :: proc(t: ^testing.T) {
	testing.expect_value(t, square_of_sum(5), 225)
}

@(test)
test_square_of_sum_100 :: proc(t: ^testing.T) {
	testing.expect_value(t, square_of_sum(100), 25_502_500)
}

@(test)
sum_of_squares_1_test :: proc(t: ^testing.T) {
	testing.expect_value(t, sum_of_squares(1), 1)
}

@(test)
sum_of_squares_5_test :: proc(t: ^testing.T) {
	testing.expect_value(t, sum_of_squares(5), 55)
}

@(test)
sum_of_squares_100_test :: proc(t: ^testing.T) {
	testing.expect_value(t, sum_of_squares(100), 338_350)
}

@(test)
difference_of_squares_1_test :: proc(t: ^testing.T) {
	testing.expect_value(t, difference(1), 0)
}

@(test)
difference_of_squares_5_test :: proc(t: ^testing.T) {
	testing.expect_value(t, difference(5), 170)
}

@(test)
difference_of_squares_100_test :: proc(t: ^testing.T) {
	testing.expect_value(t, difference(100), 25_164_150)
}
