package list_ops

import "core:fmt"
import "core:testing"

expect_slices_match :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {

	result := fmt.aprintf("%v", actual)
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str)
}

// In the following tests, instead of allocating memory using the context
// primary allocator, we use the context temporary allocator (an arena) and then
// free all its allocation in one swoop with `free_all()`. We replace
// the context primary allocator with the temporary allocator which carries in the
// test procedure and all procedures it calls recursively.
// This makes the test code easier to read.

@(test)
test_append_entries_to_a_list_and_return_the_new_list__empty_lists :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	result := ls_append([]int{}, []int{})
	expect_slices_match(t, result, []int{})
}

@(test)
test_append_entries_to_a_list_and_return_the_new_list__list_to_empty_list :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	result := ls_append([]int{}, []int{1, 2, 3, 4})

	expect_slices_match(t, result, []int{1, 2, 3, 4})
}

@(test)
test_append_entries_to_a_list_and_return_the_new_list__empty_list_to_list :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	result := ls_append([]int{1, 2, 3, 4}, []int{})

	expect_slices_match(t, result, []int{1, 2, 3, 4})
}

@(test)
test_append_entries_to_a_list_and_return_the_new_list__non_empty_lists :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	result := ls_append([]int{1, 2}, []int{2, 3, 4, 5})

	expect_slices_match(t, result, []int{1, 2, 2, 3, 4, 5})
}

@(test)
test_concatenate_a_list_of_lists__empty_list :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	result := ls_concat([][]int{})

	expect_slices_match(t, result, []int{})
}

@(test)
test_concatenate_a_list_of_lists__list_of_lists :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	input := [][]int{[]int{1, 2}, []int{3}, []int{}, []int{4, 5, 6}}
	result := ls_concat(input)

	expect_slices_match(t, result, []int{1, 2, 3, 4, 5, 6})
}

@(test)
test_concatenate_a_list_of_lists__list_of_nested_lists :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	input := [][][]int {
		[][]int{[]int{1}, []int{2}},
		[][]int{[]int{3}},
		[][]int{[]int{}},
		[][]int{[]int{4, 5, 6}},
	}

	result := ls_concat(input)

	// I was wrong about needing to implement an `expect_2d_slices_math()` for 2D slices.
	// Because `expect_slices_match()` convert the slice type to a string (regardless of the type)
	// it doesn't matter if it is an `int`` or a `[]int`.
	// We may have experimented with a version of non-generic version of `expect_slices_match()`
	// when that problem came up last time.
	expect_slices_match(t, result, [][]int{[]int{1}, []int{2}, []int{3}, []int{}, []int{4, 5, 6}})
}

@(test)
test_filter_list_returning_only_values_that_satisfy_the_filter_function__empty_list :: proc(
	t: ^testing.T,
) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	odd :: proc(x: int) -> bool { return x % 2 == 1 }
	result := ls_filter([]int{}, odd)

	expect_slices_match(t, result, []int{})
}

@(test)
test_filter_list_returning_only_values_that_satisfy_the_filter_function__non_empty_list :: proc(
	t: ^testing.T,
) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	odd :: proc(x: int) -> bool { return x % 2 == 1 }
	result := ls_filter([]int{1, 2, 3, 5}, odd)

	expect_slices_match(t, result, []int{1, 3, 5})
}

@(test)
test_returns_the_length_of_a_list__empty_list :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	result := ls_length([]int{})

	testing.expect_value(t, result, 0)
}

@(test)
test_returns_the_length_of_a_list__non_empty_list :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	result := ls_length([]int{1, 2, 3, 4})

	testing.expect_value(t, result, 4)
}

@(test)
test_return_a_list_of_elements_whose_values_equal_the_list_value_transformed_by_the_mapping_function__empty_list :: proc(
	t: ^testing.T,
) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	inc :: proc(x: int) -> int { return x + 1 }
	result := ls_map([]int{}, inc)

	expect_slices_match(t, result, []int{})
}

@(test)
test_return_a_list_of_elements_whose_values_equal_the_list_value_transformed_by_the_mapping_function__non_empty_list :: proc(
	t: ^testing.T,
) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	inc :: proc(x: int) -> int { return x + 1 }

	result := ls_map([]int{1, 3, 5, 7}, inc)
	expect_slices_match(t, result, []int{2, 4, 6, 8})
}

@(test)
test_folds_reduces_the_given_list_from_the_left_with_a_function__empty_list :: proc(
	t: ^testing.T,
) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	prod :: proc(acc, el: int) -> int { return el * acc }
	result := ls_foldl([]int{}, 2, prod)

	testing.expect_value(t, result, 2)
}

@(test)
test_folds_reduces_the_given_list_from_the_left_with_a_function__direction_independent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	sum :: proc(acc, el: int) -> int { return el + acc }
	result := ls_foldl([]int{1, 2, 3, 4}, 5, sum)

	testing.expect_value(t, result, 15)
}

@(test)
test_folds_reduces_the_given_list_from_the_left_with_a_function__direction_dependent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	// Per the description of the test (uuid: "d7fcad99-e88e-40e1-a539-4c519681f390")
	// this test must use floating point division.
	div :: proc(acc, el: f64) -> f64 { return el / acc }
	result := ls_foldl([]f64{1.0, 2.0, 3.0, 4.0}, 24.0, div)

	testing.expect_value(t, result, 64.0)
}

@(test)
test_folds_reduces_the_given_list_from_the_right_with_a_function__empty_list :: proc(
	t: ^testing.T,
) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	prod :: proc(acc, el: int) -> int { return el * acc }
	result := ls_foldr([]int{}, 2, prod)

	testing.expect_value(t, result, 2)
}

@(test)
test_folds_reduces_the_given_list_from_the_right_with_a_function__direction_independent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	sum :: proc(acc, el: int) -> int { return el + acc }
	result := ls_foldr([]int{1, 2, 3, 4}, 5, sum)

	testing.expect_value(t, result, 15)
}

@(test)
test_folds_reduces_the_given_list_from_the_right_with_a_function__direction_dependent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	// Per the description of the test (uuid: "8066003b-f2ff-437e-9103-66e6df474844")
	// this test must use floating point division.
	div :: proc(acc, el: f64) -> f64 { return el / acc }
	result := ls_foldr([]f64{1.0, 2.0, 3.0, 4.0}, 24.0, div)

	testing.expect_value(t, result, 9.0)
}

@(test)
test_reverse_the_elements_of_the_list__empty_list :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	result := ls_reverse([]int{})

	expect_slices_match(t, result, []int{})
}

@(test)
test_reverse_the_elements_of_the_list__non_empty_list :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	result := ls_reverse([]int{1, 3, 5, 7})

	expect_slices_match(t, result, []int{7, 5, 3, 1})
}

@(test)
test_reverse_the_elements_of_the_list__list_of_lists_is_not_flattened :: proc(t: ^testing.T) {

	context.allocator = context.temp_allocator
	defer free_all(context.allocator)

	input := [][]int{[]int{1, 2}, []int{3}, []int{}, []int{4, 5, 6}}
	result := ls_reverse(input)

	expect_slices_match(t, result, [][]int{[]int{4, 5, 6}, []int{}, []int{3}, []int{1, 2}})
}
