package sublist

import "core:testing"

@(test)
/// description = empty lists
test_empty_lists :: proc(t: ^testing.T) {
	a: []int = {}
	b: []int = {}
	result := compare(a, b)

	testing.expect(t, result == .Equal)
}

@(test)
/// description = empty list within non empty list
test_empty_list_within_non_empty_list :: proc(t: ^testing.T) {
	a: []int = {}
	b := []int{1, 2, 3}
	result := compare(a, b)

	testing.expect(t, result == .Sublist)
}

@(test)
/// description = non empty list contains empty list
test_non_empty_list_contains_empty_list :: proc(t: ^testing.T) {
	a := []int{1, 2, 3}
	b: []int = {}
	result := compare(a, b)

	testing.expect(t, result == .Superlist)
}

@(test)
/// description = list equals itself
test_list_equals_itself :: proc(t: ^testing.T) {
	a := []int{1, 2, 3}
	b := []int{1, 2, 3}
	result := compare(a, b)

	testing.expect(t, result == .Equal)
}

@(test)
/// description = different lists
test_different_lists :: proc(t: ^testing.T) {
	a := []int{1, 2, 3}
	b := []int{2, 3, 4}
	result := compare(a, b)

	testing.expect(t, result == .Unequal)
}

@(test)
/// description = false start
test_false_start :: proc(t: ^testing.T) {
	a := []int{1, 2, 5}
	b := []int{0, 1, 2, 3, 1, 2, 5, 6}
	result := compare(a, b)

	testing.expect(t, result == .Sublist)
}

@(test)
/// description = consecutive
test_consecutive :: proc(t: ^testing.T) {
	a := []int{1, 1, 2}
	b := []int{0, 1, 1, 1, 2, 1, 2}
	result := compare(a, b)

	testing.expect(t, result == .Sublist)
}

@(test)
/// description = sublist at start
test_sublist_at_start :: proc(t: ^testing.T) {
	a := []int{0, 1, 2}
	b := []int{0, 1, 2, 3, 4, 5}
	result := compare(a, b)

	testing.expect(t, result == .Sublist)
}

@(test)
/// description = sublist in middle
test_sublist_in_middle :: proc(t: ^testing.T) {
	a := []int{2, 3, 4}
	b := []int{0, 1, 2, 3, 4, 5}
	result := compare(a, b)

	testing.expect(t, result == .Sublist)
}

@(test)
/// description = sublist at end
test_sublist_at_end :: proc(t: ^testing.T) {
	a := []int{3, 4, 5}
	b := []int{0, 1, 2, 3, 4, 5}
	result := compare(a, b)

	testing.expect(t, result == .Sublist)
}

@(test)
/// description = at start of superlist
test_at_start_of_superlist :: proc(t: ^testing.T) {
	a := []int{0, 1, 2, 3, 4, 5}
	b := []int{0, 1, 2}
	result := compare(a, b)

	testing.expect(t, result == .Superlist)
}

@(test)
/// description = in middle of superlist
test_in_middle_of_superlist :: proc(t: ^testing.T) {
	a := []int{0, 1, 2, 3, 4, 5}
	b := []int{2, 3}
	result := compare(a, b)

	testing.expect(t, result == .Superlist)
}

@(test)
/// description = at end of superlist
test_at_end_of_superlist :: proc(t: ^testing.T) {
	a := []int{0, 1, 2, 3, 4, 5}
	b := []int{3, 4, 5}
	result := compare(a, b)

	testing.expect(t, result == .Superlist)
}

@(test)
/// description = first list missing element from second list
test_first_list_missing_element_from_second_list :: proc(t: ^testing.T) {
	a := []int{1, 3}
	b := []int{1, 2, 3}
	result := compare(a, b)

	testing.expect(t, result == .Unequal)
}

@(test)
/// description = second list missing element from first list
test_second_list_missing_element_from_first_list :: proc(t: ^testing.T) {
	a := []int{1, 2, 3}
	b := []int{1, 3}
	result := compare(a, b)

	testing.expect(t, result == .Unequal)
}

@(test)
/// description = first list missing additional digits from second list
test_first_list_missing_additional_digits_from_second_list :: proc(t: ^testing.T) {
	a := []int{1, 2}
	b := []int{1, 22}
	result := compare(a, b)

	testing.expect(t, result == .Unequal)
}

@(test)
/// description = order matters to a list
test_order_matters_to_a_list :: proc(t: ^testing.T) {
	a := []int{1, 2, 3}
	b := []int{3, 2, 1}
	result := compare(a, b)

	testing.expect(t, result == .Unequal)
}

@(test)
/// description = same digits but different numbers
test_same_digits_but_different_numbers :: proc(t: ^testing.T) {
	a := []int{1, 0, 1}
	b := []int{10, 1}
	result := compare(a, b)

	testing.expect(t, result == .Unequal)
}

@(test)
/// description = recurring values sublist
test_recurring_values_sublist :: proc(t: ^testing.T) {
	a := []int{1, 2, 1, 2, 3}
	b := []int{1, 2, 3, 1, 2, 1, 2, 3, 2, 1}
	result := compare(a, b)

	testing.expect(t, result == .Sublist)
}

@(test)
/// description = recurring values unequal
test_recurring_values_unequal :: proc(t: ^testing.T) {
	a := []int{1, 2, 1, 2, 3}
	b := []int{1, 2, 3, 1, 2, 3, 2, 3, 2, 1}
	result := compare(a, b)

	testing.expect(t, result == .Unequal)
}

@(test)
/// description = at end of partially matching superlist
test_at_end_of_partially_matching_superlist :: proc(t: ^testing.T) {
	a := []int{1, 1, 1, 2}
	b := []int{1, 1, 2}
	result := compare(a, b)

	testing.expect(t, result == .Superlist)
}

@(test)
/// description = partially matching sublist at end
test_partially_matching_sublist_at_end :: proc(t: ^testing.T) {
	a := []int{1, 1, 2}
	b := []int{1, 1, 1, 2}
	result := compare(a, b)

	testing.expect(t, result == .Sublist)
}

@(test)
/// description = comparing masshugeive equal lists (1_000_000 elements)
test_huge_equal_lists :: proc(t: ^testing.T) {
	n := 1_000_000
	a := make([]int, n)
	defer delete(a)
	b := make([]int, n)
	defer delete(b)
	for i := 0; i < n; i += 1 {
		a[i] = i + 1
		b[i] = i + 1
	}
	result := compare(a, b)

	testing.expect(t, result == .Equal)
}

@(test)
/// description = sublist early in huge list
test_sublist_early_in_huge_list :: proc(t: ^testing.T) {
	n := 1_000_000
	b := make([]int, n)
	defer delete(b)
	for i := 0; i < n; i += 1 {
		b[i] = i + 1
	}
	a := []int{3, 4, 5}
	result := compare(a, b)

	testing.expect(t, result == .Sublist)
}

@(test)
/// description = huge sublist not in huge list
test_huge_sublist_not_in_huge_list :: proc(t: ^testing.T) {
	n := 1_000_000
	a := make([]int, n)
	defer delete(a)
	b := make([]int, n)
	defer delete(b)
	for i := 0; i < n; i += 1 {
		a[i] = i + 10 // 10..1_000_009
		b[i] = i + 1 // 1..1_000_000
	}
	result := compare(a, b)

	testing.expect(t, result == .Unequal)
}

@(test)
/// description = superlist early in huge list
test_superlist_early_in_huge_list :: proc(t: ^testing.T) {
	n := 1_000_000
	a := make([]int, n)
	defer delete(a)
	for i := 0; i < n; i += 1 {
		a[i] = i + 1
	}
	b := []int{3, 4, 5}
	result := compare(a, b)

	testing.expect(t, result == .Superlist)
}
