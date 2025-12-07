package pythagorean_triplet

import "core:testing"

array_equal :: proc(a, b: []$T) -> bool {
	if len(a) != len(b) {
		return false
	}
	for i in 0 ..< len(a) {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}

@(test)
/// description = triplets whose sum is 12
test_triplets_whose_sum_is_12 :: proc(t: ^testing.T) {
	expected: []Triplet = {{3, 4, 5}}
	actual := triplets_with_sum(12)
	defer delete(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = triplets whose sum is 108
test_triplets_whose_sum_is_108 :: proc(t: ^testing.T) {
	expected: []Triplet = {{27, 36, 45}}
	actual := triplets_with_sum(108)
	defer delete(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = triplets whose sum is 1000
test_triplets_whose_sum_is_1000 :: proc(t: ^testing.T) {
	expected: []Triplet = {{200, 375, 425}}
	actual := triplets_with_sum(1000)
	defer delete(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = no matching triplets for 1001
test_no_matching_triplets_for_1001 :: proc(t: ^testing.T) {
	expected: []Triplet = {}
	actual := triplets_with_sum(1001)
	defer delete(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = triplets whose sum is 90
test_triplets_whose_sum_is_90 :: proc(t: ^testing.T) {
	expected: []Triplet = {{9, 40, 41}, {15, 36, 39}}
	actual := triplets_with_sum(90)
	defer delete(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = triplets whose sum is 840
test_triplets_whose_sum_is_840 :: proc(t: ^testing.T) {
	expected: []Triplet = {
		{40, 399, 401},
		{56, 390, 394},
		{105, 360, 375},
		{120, 350, 370},
		{140, 336, 364},
		{168, 315, 357},
		{210, 280, 350},
		{240, 252, 348},
	}
	actual := triplets_with_sum(840)
	defer delete(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}

@(test)
/// description = triplets for large number
test_triplets_for_large_number :: proc(t: ^testing.T) {
	expected: []Triplet = {
		{1200, 14375, 14425},
		{1875, 14000, 14125},
		{5000, 12000, 13000},
		{6000, 11250, 12750},
		{7500, 10000, 12500},
	}
	actual := triplets_with_sum(30000)
	defer delete(actual)
	testing.expectf(t, array_equal(actual, expected), "expected %v got %v", expected, actual)
}
