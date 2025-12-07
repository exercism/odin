package two_bucket

import "core:testing"

@(test)
/// description = Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one
test_measure_using_bucket_one_of_size_3_and_bucket_two_of_size_5___start_with_bucket_one :: proc(
	t: ^testing.T,
) {

	result, valid := measure(bucket_one = 3, bucket_two = 5, goal = 1, start_bucket = "one")

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 4)
	testing.expect_value(t, result.goal_bucket, "one")
	testing.expect_value(t, result.other_bucket, 5)
}

@(test)
/// description = Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two
test_measure_using_bucket_one_of_size_3_and_bucket_two_of_size_5___start_with_bucket_two :: proc(
	t: ^testing.T,
) {

	result, valid := measure(bucket_one = 3, bucket_two = 5, goal = 1, start_bucket = "two")

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 8)
	testing.expect_value(t, result.goal_bucket, "two")
	testing.expect_value(t, result.other_bucket, 3)
}

@(test)
/// description = Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one
test_measure_using_bucket_one_of_size_7_and_bucket_two_of_size_11___start_with_bucket_one :: proc(
	t: ^testing.T,
) {

	result, valid := measure(bucket_one = 7, bucket_two = 11, goal = 2, start_bucket = "one")

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 14)
	testing.expect_value(t, result.goal_bucket, "one")
	testing.expect_value(t, result.other_bucket, 11)
}

@(test)
/// description = Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two
test_measure_using_bucket_one_of_size_7_and_bucket_two_of_size_11___start_with_bucket_two :: proc(
	t: ^testing.T,
) {

	result, valid := measure(bucket_one = 7, bucket_two = 11, goal = 2, start_bucket = "two")

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 18)
	testing.expect_value(t, result.goal_bucket, "two")
	testing.expect_value(t, result.other_bucket, 7)
}

@(test)
/// description = Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two
test_measure_one_step_using_bucket_one_of_size_1_and_bucket_two_of_size_3___start_with_bucket_two :: proc(
	t: ^testing.T,
) {

	result, valid := measure(bucket_one = 1, bucket_two = 3, goal = 3, start_bucket = "two")

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 1)
	testing.expect_value(t, result.goal_bucket, "two")
	testing.expect_value(t, result.other_bucket, 0)
}

@(test)
/// description = Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two
test_measure_using_bucket_one_of_size_2_and_bucket_two_of_size_3___start_with_bucket_one_and_end_with_bucket_two :: proc(
	t: ^testing.T,
) {

	result, valid := measure(bucket_one = 2, bucket_two = 3, goal = 3, start_bucket = "one")

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 2)
	testing.expect_value(t, result.goal_bucket, "two")
	testing.expect_value(t, result.other_bucket, 2)
}

@(test)
/// description = Measure using bucket one much bigger than bucket two
test_measure_using_bucket_one_much_bigger_than_bucket_two :: proc(t: ^testing.T) {

	result, valid := measure(bucket_one = 5, bucket_two = 1, goal = 2, start_bucket = "one")

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 6)
	testing.expect_value(t, result.goal_bucket, "one")
	testing.expect_value(t, result.other_bucket, 1)
}

@(test)
/// description = Measure using bucket one much smaller than bucket two
test_measure_using_bucket_one_much_smaller_than_bucket_two :: proc(t: ^testing.T) {

	result, valid := measure(bucket_one = 3, bucket_two = 15, goal = 9, start_bucket = "one")

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 6)
	testing.expect_value(t, result.goal_bucket, "two")
	testing.expect_value(t, result.other_bucket, 0)
}

@(test)
/// description = Not possible to reach the goal
test_not_possible_to_reach_the_goal :: proc(t: ^testing.T) {

	_, valid := measure(bucket_one = 6, bucket_two = 15, goal = 5, start_bucket = "one")

	testing.expect_value(t, valid, false)
}

@(test)
/// description = With the same buckets but a different goal, then it is possible
test_with_the_same_buckets_but_a_different_goal_then_it_is_possible :: proc(t: ^testing.T) {

	result, valid := measure(bucket_one = 6, bucket_two = 15, goal = 9, start_bucket = "one")

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 10)
	testing.expect_value(t, result.goal_bucket, "two")
	testing.expect_value(t, result.other_bucket, 0)
}

@(test)
/// description = Goal larger than both buckets is impossible
test_goal_larger_than_both_buckets_is_impossible :: proc(t: ^testing.T) {

	_, valid := measure(bucket_one = 5, bucket_two = 7, goal = 8, start_bucket = "one")

	testing.expect_value(t, valid, false)
}
