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

	testing.expect_value(t, result, exp_str, loc = loc)
}

@(test)
/// description = append entries to a list and return the new list -> empty lists
test_append_entries_to_a_list_and_return_the_new_list__empty_lists :: proc(t: ^testing.T) {

	result := ls_append([]int{}, []int{})
	defer delete(result)

	expect_slices_match(t, result, []int{})
}

@(test)
/// description = append entries to a list and return the new list -> list to empty list
test_append_entries_to_a_list_and_return_the_new_list__list_to_empty_list :: proc(t: ^testing.T) {

	result := ls_append([]int{}, []int{1, 2, 3, 4})
	defer delete(result)

	expect_slices_match(t, result, []int{1, 2, 3, 4})
}

@(test)
/// description = append entries to a list and return the new list -> empty list to list
test_append_entries_to_a_list_and_return_the_new_list__empty_list_to_list :: proc(t: ^testing.T) {

	result := ls_append([]int{1, 2, 3, 4}, []int{})
	defer delete(result)

	expect_slices_match(t, result, []int{1, 2, 3, 4})
}

@(test)
/// description = append entries to a list and return the new list -> non-empty lists
test_append_entries_to_a_list_and_return_the_new_list__non_empty_lists :: proc(t: ^testing.T) {

	result := ls_append([]int{1, 2}, []int{2, 3, 4, 5})
	defer delete(result)

	expect_slices_match(t, result, []int{1, 2, 2, 3, 4, 5})
}

@(test)
/// description = concatenate a list of lists -> empty list
test_concatenate_a_list_of_lists__empty_list :: proc(t: ^testing.T) {

	result := ls_concat([][]int{})
	defer delete(result)

	expect_slices_match(t, result, []int{})
}

@(test)
/// description = concatenate a list of lists -> list of lists
test_concatenate_a_list_of_lists__list_of_lists :: proc(t: ^testing.T) {

	input := [][]int{[]int{1, 2}, []int{3}, []int{}, []int{4, 5, 6}}
	result := ls_concat(input)
	defer delete(result)

	expect_slices_match(t, result, []int{1, 2, 3, 4, 5, 6})
}

@(test)
/// description = concatenate a list of lists -> list of nested lists
test_concatenate_a_list_of_lists__list_of_nested_lists :: proc(t: ^testing.T) {

	input := [][][]int {
		[][]int{[]int{1}, []int{2}},
		[][]int{[]int{3}},
		[][]int{[]int{}},
		[][]int{[]int{4, 5, 6}},
	}

	result := ls_concat(input)
	defer delete(result)

	expect_slices_match(t, result, [][]int{[]int{1}, []int{2}, []int{3}, []int{}, []int{4, 5, 6}})
}

@(test)
/// description = filter list returning only values that satisfy the filter function -> empty list
test_filter_list_returning_only_values_that_satisfy_the_filter_function__empty_list :: proc(
	t: ^testing.T,
) {

	odd :: proc(x: int) -> bool { return x % 2 == 1 }
	result := ls_filter([]int{}, odd)
	defer delete(result)

	expect_slices_match(t, result, []int{})
}

@(test)
/// description = filter list returning only values that satisfy the filter function -> non-empty list
test_filter_list_returning_only_values_that_satisfy_the_filter_function__non_empty_list :: proc(
	t: ^testing.T,
) {

	odd :: proc(x: int) -> bool { return x % 2 == 1 }
	result := ls_filter([]int{1, 2, 3, 5}, odd)
	defer delete(result)

	expect_slices_match(t, result, []int{1, 3, 5})
}

@(test)
/// description = returns the length of a list -> empty list
test_returns_the_length_of_a_list__empty_list :: proc(t: ^testing.T) {

	result := ls_length([]int{})

	testing.expect_value(t, result, 0)
}

@(test)
/// description = returns the length of a list -> non-empty list
test_returns_the_length_of_a_list__non_empty_list :: proc(t: ^testing.T) {

	result := ls_length([]int{1, 2, 3, 4})

	testing.expect_value(t, result, 4)
}

@(test)
/// description = return a list of elements whose values equal the list value transformed by the mapping function -> empty list
test_return_a_list_of_elements_whose_values_equal_the_list_value_transformed_by_the_mapping_function__empty_list :: proc(
	t: ^testing.T,
) {

	inc :: proc(x: int) -> int { return x + 1 }
	result := ls_map([]int{}, inc)
	defer delete(result)

	expect_slices_match(t, result, []int{})
}

@(test)
/// description = return a list of elements whose values equal the list value transformed by the mapping function -> non-empty list
test_return_a_list_of_elements_whose_values_equal_the_list_value_transformed_by_the_mapping_function__non_empty_list :: proc(
	t: ^testing.T,
) {

	inc :: proc(x: int) -> int { return x + 1 }
	result := ls_map([]int{1, 3, 5, 7}, inc)
	defer delete(result)

	expect_slices_match(t, result, []int{2, 4, 6, 8})
}

@(test)
/// description = foldl (reduces) the given list to the type of accumulator
test_foldl_reduces_the_given_list_to_the_type_of_accumulator :: proc(t: ^testing.T) {
	sum_f64_and_int :: proc(acc: f64, el: int) -> f64 { return acc + f64(el) }

	list := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	result := ls_foldl(list, f64(0), sum_f64_and_int)
	testing.expect_value(t, result, 55.0)
}

@(test)
/// description = foldr (reduces) the given list to the type of accumulator
test_foldr_reduces_the_given_list_to_the_type_of_accumulator :: proc(t: ^testing.T) {
	sum_f64_and_int :: proc(acc: f64, el: int) -> f64 { return acc + f64(el) }

	list := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	result := ls_foldr(list, f64(0), sum_f64_and_int)
	testing.expect_value(t, result, 55.0)
}

@(test)
/// description = folds (reduces) the given list from the left with a function -> empty list
test_folds_reduces_the_given_list_from_the_left_with_a_function__empty_list :: proc(
	t: ^testing.T,
) {

	prod :: proc(acc, el: int) -> int { return el * acc }
	result := ls_foldl([]int{}, 2, prod)

	testing.expect_value(t, result, 2)
}

@(test)
/// description = folds (reduces) the given list from the left with a function -> direction independent function applied to non-empty list
test_folds_reduces_the_given_list_from_the_left_with_a_function__direction_independent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {

	sum :: proc(acc, el: int) -> int { return el + acc }
	result := ls_foldl([]int{1, 2, 3, 4}, 5, sum)

	testing.expect_value(t, result, 15)
}

@(test)
/// description = folds (reduces) the given list from the left with a function -> direction dependent function applied to non-empty list
test_folds_reduces_the_given_list_from_the_left_with_a_function__direction_dependent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {

	// Per the description of the test (uuid: "d7fcad99-e88e-40e1-a539-4c519681f390")
	// this test must use floating point division.
	div :: proc(acc, el: f64) -> f64 { return el / acc }
	result := ls_foldl([]f64{1.0, 2.0, 3.0, 4.0}, 24.0, div)

	testing.expect_value(t, result, 64.0)
}

@(test)
/// description = folds (reduces) the given list from the right with a function -> empty list
test_folds_reduces_the_given_list_from_the_right_with_a_function__empty_list :: proc(
	t: ^testing.T,
) {

	prod :: proc(acc, el: int) -> int { return el * acc }
	result := ls_foldr([]int{}, 2, prod)

	testing.expect_value(t, result, 2)
}

@(test)
/// description = folds (reduces) the given list from the right with a function -> direction independent function applied to non-empty list
test_folds_reduces_the_given_list_from_the_right_with_a_function__direction_independent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {

	sum :: proc(acc, el: int) -> int { return el + acc }
	result := ls_foldr([]int{1, 2, 3, 4}, 5, sum)

	testing.expect_value(t, result, 15)
}

@(test)
/// description = folds (reduces) the given list from the right with a function -> direction dependent function applied to non-empty list
test_folds_reduces_the_given_list_from_the_right_with_a_function__direction_dependent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {

	// Per the description of the test (uuid: "8066003b-f2ff-437e-9103-66e6df474844")
	// this test must use floating point division.
	div :: proc(acc, el: f64) -> f64 { return el / acc }
	result := ls_foldr([]f64{1.0, 2.0, 3.0, 4.0}, 24.0, div)

	testing.expect_value(t, result, 9.0)
}

@(test)
/// description = reverse the elements of the list -> empty list
test_reverse_the_elements_of_the_list__empty_list :: proc(t: ^testing.T) {

	result := ls_reverse([]int{})
	defer delete(result)

	expect_slices_match(t, result, []int{})
}

@(test)
/// description = reverse the elements of the list -> non-empty list
test_reverse_the_elements_of_the_list__non_empty_list :: proc(t: ^testing.T) {

	result := ls_reverse([]int{1, 3, 5, 7})
	defer delete(result)

	expect_slices_match(t, result, []int{7, 5, 3, 1})
}

@(test)
/// description = reverse the elements of the list -> list of lists is not flattened
test_reverse_the_elements_of_the_list__list_of_lists_is_not_flattened :: proc(t: ^testing.T) {

	input := [][]int{[]int{1, 2}, []int{3}, []int{}, []int{4, 5, 6}}
	result := ls_reverse(input)
	defer delete(result)

	expect_slices_match(t, result, [][]int{[]int{4, 5, 6}, []int{}, []int{3}, []int{1, 2}})
}
