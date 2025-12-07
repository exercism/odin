package pascals_triangle

import "core:log"
import "core:slice"
import "core:testing"
import "core:time"

array_equal :: proc(a, b: [][]$T) -> bool {
	if len(a) != len(b) {
		return false
	}
	for i in 0 ..< len(a) {
		if !slice.equal(a[i], b[i]) {
			return false
		}
	}
	return true
}

delete_array :: proc(a: [][]$T) {
	for row in a {
		delete(row)
	}
	delete(a)
}

@(test)
/// description = zero rows
test_zero_rows :: proc(t: ^testing.T) {
	expected: [][]u128 = {}
	actual := rows(0)
	defer delete_array(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = single row
test_single_row :: proc(t: ^testing.T) {
	expected: [][]u128 = {{1}}
	actual := rows(1)
	defer delete_array(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = two rows
test_two_rows :: proc(t: ^testing.T) {
	expected: [][]u128 = {{1}, {1, 1}}
	actual := rows(2)
	defer delete_array(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = three rows
test_three_rows :: proc(t: ^testing.T) {
	expected: [][]u128 = {{1}, {1, 1}, {1, 2, 1}}
	actual := rows(3)
	defer delete_array(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = four rows
test_four_rows :: proc(t: ^testing.T) {
	expected: [][]u128 = {{1}, {1, 1}, {1, 2, 1}, {1, 3, 3, 1}}
	actual := rows(4)
	defer delete_array(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = five rows
test_five_rows :: proc(t: ^testing.T) {
	expected: [][]u128 = {{1}, {1, 1}, {1, 2, 1}, {1, 3, 3, 1}, {1, 4, 6, 4, 1}}
	actual := rows(5)
	defer delete_array(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = six rows
test_six_rows :: proc(t: ^testing.T) {
	expected: [][]u128 = {
		{1},
		{1, 1},
		{1, 2, 1},
		{1, 3, 3, 1},
		{1, 4, 6, 4, 1},
		{1, 5, 10, 10, 5, 1},
	}
	actual := rows(6)
	defer delete_array(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = ten rows
test_ten_rows :: proc(t: ^testing.T) {
	expected: [][]u128 = {
		{1},
		{1, 1},
		{1, 2, 1},
		{1, 3, 3, 1},
		{1, 4, 6, 4, 1},
		{1, 5, 10, 10, 5, 1},
		{1, 6, 15, 20, 15, 6, 1},
		{1, 7, 21, 35, 35, 21, 7, 1},
		{1, 8, 28, 56, 70, 56, 28, 8, 1},
		{1, 9, 36, 84, 126, 126, 84, 36, 9, 1},
	}
	actual := rows(10)
	defer delete_array(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = seventy five rows
test_seventy_five_rows :: proc(t: ^testing.T) {
	actual := rows(75)
	defer delete_array(actual)
	testing.expect_value(t, actual[74][37], 17_46_130_564_335_626_209_832)
}

// Optional Benchmarking Code
// If you are using Exercism CLI Interface and want to test
// the performance of your solution, uncomment the following
// test attribute.

// @(test)
benchmark_pascals_triangle :: proc(t: ^testing.T) {
	N :: 500
	ROUNDS :: 10
	options := &time.Benchmark_Options {
		rounds = ROUNDS,
		bench = proc(
			opt: ^time.Benchmark_Options,
			allocator := context.allocator,
		) -> time.Benchmark_Error {
			for _ in 0 ..< opt.rounds {
				rows := rows(N)
				defer delete_array(rows)
				for r in rows {
					opt.processed += len(r) * size_of(u128)
				}
			}
			return nil
		},
	}
	time.benchmark(options)
	log.infof(
		"Benchmark finished in %v, speed: %0.2f MB/s",
		options.duration,
		options.megabytes_per_second,
	)
}
