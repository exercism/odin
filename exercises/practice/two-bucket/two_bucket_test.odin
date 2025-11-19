package two_bucket

import "core:testing"

@(test)
test_measure_using_bucket_one_of_size_3_and_bucket_two_of_size_5___start_with_bucket_one :: proc(
	t: ^testing.T,
) {

	result, valid := measure(
		bucketOne = 3,
		bucketTwo = 5,
		goal = 1,
		startBucket = "one",
	)

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 4)
	testing.expect_value(t, result.goalBucket, "one")
	testing.expect_value(t, result.otherBucket, 5)
}

// @(test)
test_measure_using_bucket_one_of_size_3_and_bucket_two_of_size_5___start_with_bucket_two :: proc(
	t: ^testing.T,
) {

	result, valid := measure(
		bucketOne = 3,
		bucketTwo = 5,
		goal = 1,
		startBucket = "two",
	)

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 8)
	testing.expect_value(t, result.goalBucket, "two")
	testing.expect_value(t, result.otherBucket, 3)
}

// @(test)
test_measure_using_bucket_one_of_size_7_and_bucket_two_of_size_11___start_with_bucket_one :: proc(
	t: ^testing.T,
) {

	result, valid := measure(
		bucketOne = 7,
		bucketTwo = 11,
		goal = 2,
		startBucket = "one",
	)

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 14)
	testing.expect_value(t, result.goalBucket, "one")
	testing.expect_value(t, result.otherBucket, 11)
}

// @(test)
test_measure_using_bucket_one_of_size_7_and_bucket_two_of_size_11___start_with_bucket_two :: proc(
	t: ^testing.T,
) {

	result, valid := measure(
		bucketOne = 7,
		bucketTwo = 11,
		goal = 2,
		startBucket = "two",
	)

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 18)
	testing.expect_value(t, result.goalBucket, "two")
	testing.expect_value(t, result.otherBucket, 7)
}

// @(test)
test_measure_one_step_using_bucket_one_of_size_1_and_bucket_two_of_size_3___start_with_bucket_two :: proc(
	t: ^testing.T,
) {

	result, valid := measure(
		bucketOne = 1,
		bucketTwo = 3,
		goal = 3,
		startBucket = "two",
	)

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 1)
	testing.expect_value(t, result.goalBucket, "two")
	testing.expect_value(t, result.otherBucket, 0)
}

// @(test)
test_measure_using_bucket_one_of_size_2_and_bucket_two_of_size_3___start_with_bucket_one_and_end_with_bucket_two :: proc(
	t: ^testing.T,
) {

	result, valid := measure(
		bucketOne = 2,
		bucketTwo = 3,
		goal = 3,
		startBucket = "one",
	)

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 2)
	testing.expect_value(t, result.goalBucket, "two")
	testing.expect_value(t, result.otherBucket, 2)
}

// @(test)
test_measure_using_bucket_one_much_bigger_than_bucket_two :: proc(
	t: ^testing.T,
) {

	result, valid := measure(
		bucketOne = 5,
		bucketTwo = 1,
		goal = 2,
		startBucket = "one",
	)

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 6)
	testing.expect_value(t, result.goalBucket, "one")
	testing.expect_value(t, result.otherBucket, 1)
}

// @(test)
test_measure_using_bucket_one_much_smaller_than_bucket_two :: proc(
	t: ^testing.T,
) {

	result, valid := measure(
		bucketOne = 3,
		bucketTwo = 15,
		goal = 9,
		startBucket = "one",
	)

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 6)
	testing.expect_value(t, result.goalBucket, "two")
	testing.expect_value(t, result.otherBucket, 0)
}

// @(test)
test_not_possible_to_reach_the_goal :: proc(t: ^testing.T) {

	result, valid := measure(
		bucketOne = 6,
		bucketTwo = 15,
		goal = 5,
		startBucket = "one",
	)

	testing.expect_value(t, valid, false)
}

// @(test)
test_with_the_same_buckets_but_a_different_goal_then_it_is_possible :: proc(
	t: ^testing.T,
) {

	result, valid := measure(
		bucketOne = 6,
		bucketTwo = 15,
		goal = 9,
		startBucket = "one",
	)

	testing.expect_value(t, valid, true)
	testing.expect_value(t, result.moves, 10)
	testing.expect_value(t, result.goalBucket, "two")
	testing.expect_value(t, result.otherBucket, 0)
}

// @(test)
test_goal_larger_than_both_buckets_is_impossible :: proc(t: ^testing.T) {

	result, valid := measure(
		bucketOne = 5,
		bucketTwo = 7,
		goal = 8,
		startBucket = "one",
	)

	testing.expect_value(t, valid, false)
}
