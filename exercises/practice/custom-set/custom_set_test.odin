package custom_set

import "core:testing"

@(test)
/// description = To string -> Empty set
test_to_string__empty_set :: proc(t: ^testing.T) {

	set := new_set()
	result := to_string(set)
	defer {
		delete(set)
		delete(result)
	}
	testing.expect_value(t, result, "[]")
}

@(test)
/// description = To string -> Non empty set
test_to_string__non_empty_set :: proc(t: ^testing.T) {

	set := new_set(2, 1, 3)
	result := to_string(set)
	defer {
		delete(set)
		delete(result)
	}

	testing.expect_value(t, result, "[1, 2, 3]")
}

@(test)
/// description = To string -> Set with duplicates
test_to_string__set_with_duplicates :: proc(t: ^testing.T) {

	set := new_set(1, 1)
	result := to_string(set)
	defer {
		delete(set)
		delete(result)
	}

	testing.expect_value(t, result, "[1]")
}
@(test)
/// description = Returns true if the set contains no elements -> sets with no elements are empty
test_returns_true_if_the_set_contains_no_elements__sets_with_no_elements_are_empty :: proc(
	t: ^testing.T,
) {

	set := new_set()
	defer delete(set)
	result := is_empty(set)

	testing.expect_value(t, result, true)
}

@(test)
/// description = Returns true if the set contains no elements -> sets with elements are not empty
test_returns_true_if_the_set_contains_no_elements__sets_with_elements_are_not_empty :: proc(
	t: ^testing.T,
) {

	set := new_set(1)
	defer delete(set)
	result := is_empty(set)

	testing.expect_value(t, result, false)
}

@(test)
/// description = Sets can report if they contain an element -> nothing is contained in an empty set
test_sets_can_report_if_they_contain_an_element__nothing_is_contained_in_an_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	defer delete(set)
	result := contains(set, 1)

	testing.expect_value(t, result, false)
}

@(test)
/// description = Sets can report if they contain an element -> when the element is in the set
test_sets_can_report_if_they_contain_an_element__when_the_element_is_in_the_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3)
	defer delete(set)
	result := contains(set, 1)

	testing.expect_value(t, result, true)
}

@(test)
/// description = Sets can report if they contain an element -> when the element is not in the set
test_sets_can_report_if_they_contain_an_element__when_the_element_is_not_in_the_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3)
	defer delete(set)
	result := contains(set, 4)

	testing.expect_value(t, result, false)
}

@(test)
/// description = A set is a subset if all of its elements are contained in the other set -> empty set is a subset of another empty set
test_a_set_is_a_subset_if_all_of_its_elements_are_contained_in_the_other_set__empty_set_is_a_subset_of_another_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set()
	result := is_subset(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = A set is a subset if all of its elements are contained in the other set -> empty set is a subset of non-empty set
test_a_set_is_a_subset_if_all_of_its_elements_are_contained_in_the_other_set__empty_set_is_a_subset_of_non_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set(1)
	result := is_subset(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = A set is a subset if all of its elements are contained in the other set -> non-empty set is not a subset of empty set
test_a_set_is_a_subset_if_all_of_its_elements_are_contained_in_the_other_set__non_empty_set_is_not_a_subset_of_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1)
	other := new_set()
	result := is_subset(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, false)
}

@(test)
/// description = A set is a subset if all of its elements are contained in the other set -> set is a subset of set with exact same elements
test_a_set_is_a_subset_if_all_of_its_elements_are_contained_in_the_other_set__set_is_a_subset_of_set_with_exact_same_elements :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3)
	other := new_set(1, 2, 3)
	result := is_subset(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = A set is a subset if all of its elements are contained in the other set -> set is a subset of larger set with same elements
test_a_set_is_a_subset_if_all_of_its_elements_are_contained_in_the_other_set__set_is_a_subset_of_larger_set_with_same_elements :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3)
	other := new_set(4, 1, 2, 3)
	result := is_subset(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = A set is a subset if all of its elements are contained in the other set -> set is not a subset of set that does not contain its elements
test_a_set_is_a_subset_if_all_of_its_elements_are_contained_in_the_other_set__set_is_not_a_subset_of_set_that_does_not_contain_its_elements :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3)
	other := new_set(4, 1, 3)
	result := is_subset(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, false)
}

@(test)
/// description = Sets are disjoint if they share no elements -> the empty set is disjoint with itself
test_sets_are_disjoint_if_they_share_no_elements__the_empty_set_is_disjoint_with_itself :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set()
	result := is_disjoint(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = Sets are disjoint if they share no elements -> empty set is disjoint with non-empty set
test_sets_are_disjoint_if_they_share_no_elements__empty_set_is_disjoint_with_non_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set(1)
	result := is_disjoint(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = Sets are disjoint if they share no elements -> non-empty set is disjoint with empty set
test_sets_are_disjoint_if_they_share_no_elements__non_empty_set_is_disjoint_with_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1)
	other := new_set()
	result := is_disjoint(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = Sets are disjoint if they share no elements -> sets are not disjoint if they share an element
test_sets_are_disjoint_if_they_share_no_elements__sets_are_not_disjoint_if_they_share_an_element :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2)
	other := new_set(2, 3)
	result := is_disjoint(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, false)
}

@(test)
/// description = Sets are disjoint if they share no elements -> sets are disjoint if they share no elements
test_sets_are_disjoint_if_they_share_no_elements__sets_are_disjoint_if_they_share_no_elements :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2)
	other := new_set(3, 4)
	result := is_disjoint(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = Sets with the same elements are equal -> empty sets are equal
test_sets_with_the_same_elements_are_equal__empty_sets_are_equal :: proc(t: ^testing.T) {

	set := new_set()
	other := new_set()
	result := equal(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = Sets with the same elements are equal -> empty set is not equal to non-empty set
test_sets_with_the_same_elements_are_equal__empty_set_is_not_equal_to_non_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set(1, 2, 3)
	result := equal(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, false)
}

@(test)
/// description = Sets with the same elements are equal -> non-empty set is not equal to empty set
test_sets_with_the_same_elements_are_equal__non_empty_set_is_not_equal_to_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3)
	other := new_set()
	result := equal(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, false)
}

@(test)
/// description = Sets with the same elements are equal -> sets with the same elements are equal
test_sets_with_the_same_elements_are_equal__sets_with_the_same_elements_are_equal :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2)
	other := new_set(2, 1)
	result := equal(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = Sets with the same elements are equal -> sets with different elements are not equal
test_sets_with_the_same_elements_are_equal__sets_with_different_elements_are_not_equal :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3)
	other := new_set(1, 2, 4)
	result := equal(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, false)
}

@(test)
/// description = Sets with the same elements are equal -> set is not equal to larger set with same elements
test_sets_with_the_same_elements_are_equal__set_is_not_equal_to_larger_set_with_same_elements :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3)
	other := new_set(1, 2, 3, 4)
	result := equal(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, false)
}

@(test)
/// description = Sets with the same elements are equal -> set is equal to a set constructed from an array with duplicates
test_sets_with_the_same_elements_are_equal__set_is_equal_to_a_set_constructed_from_an_array_with_duplicates :: proc(
	t: ^testing.T,
) {

	set := new_set(1)
	other := new_set(1, 1)
	result := equal(set, other)
	defer {
		delete(set)
		delete(other)
	}

	testing.expect_value(t, result, true)
}

@(test)
/// description = Unique elements can be added to a set -> add to empty set
test_unique_elements_can_be_added_to_a_set__add_to_empty_set :: proc(t: ^testing.T) {

	set := new_set()
	add(&set, 3)
	set_as_str := to_string(set)
	defer {
		delete(set)
		delete(set_as_str)
	}

	testing.expect_value(t, set_as_str, "[3]")
}

@(test)
/// description = Unique elements can be added to a set -> add to non-empty set
test_unique_elements_can_be_added_to_a_set__add_to_non_empty_set :: proc(t: ^testing.T) {

	set := new_set(1, 2, 4)
	add(&set, 3)
	set_as_str := to_string(set)
	defer {
		delete(set)
		delete(set_as_str)
	}

	testing.expect_value(t, set_as_str, "[1, 2, 3, 4]")
}

@(test)
/// description = Unique elements can be added to a set -> adding an existing element does not change the set
test_unique_elements_can_be_added_to_a_set__adding_an_existing_element_does_not_change_the_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3)
	add(&set, 3)
	set_as_str := to_string(set)
	defer {
		delete(set)
		delete(set_as_str)
	}

	testing.expect_value(t, set_as_str, "[1, 2, 3]")
}

@(test)
/// description = Intersection returns a set of all shared elements -> intersection of two empty sets is an empty set
test_intersection_returns_a_set_of_all_shared_elements__intersection_of_two_empty_sets_is_an_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set()
	result := intersection(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[]")
}

@(test)
/// description = Intersection returns a set of all shared elements -> intersection of an empty set and non-empty set is an empty set
test_intersection_returns_a_set_of_all_shared_elements__intersection_of_an_empty_set_and_non_empty_set_is_an_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set(3, 2, 5)
	result := intersection(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[]")
}

@(test)
/// description = Intersection returns a set of all shared elements -> intersection of a non-empty set and an empty set is an empty set
test_intersection_returns_a_set_of_all_shared_elements__intersection_of_a_non_empty_set_and_an_empty_set_is_an_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3, 4)
	other := new_set()
	result := intersection(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[]")
}

@(test)
/// description = Intersection returns a set of all shared elements -> intersection of two sets with no shared elements is an empty set
test_intersection_returns_a_set_of_all_shared_elements__intersection_of_two_sets_with_no_shared_elements_is_an_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3)
	other := new_set(4, 5, 6)
	result := intersection(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[]")
}

@(test)
/// description = Intersection returns a set of all shared elements -> intersection of two sets with shared elements is a set of the shared elements
test_intersection_returns_a_set_of_all_shared_elements__intersection_of_two_sets_with_shared_elements_is_a_set_of_the_shared_elements :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3, 4)
	other := new_set(3, 2, 5)
	result := intersection(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[2, 3]")
}

@(test)
/// description = Difference (or Complement) of a set is a set of all elements that are only in the first set -> difference of two empty sets is an empty set
test_difference_or_complement_of_a_set_is_a_set_of_all_elements_that_are_only_in_the_first_set__difference_of_two_empty_sets_is_an_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set()
	result := difference(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[]")
}

@(test)
/// description = Difference (or Complement) of a set is a set of all elements that are only in the first set -> difference of empty set and non-empty set is an empty set
test_difference_or_complement_of_a_set_is_a_set_of_all_elements_that_are_only_in_the_first_set__difference_of_empty_set_and_non_empty_set_is_an_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set(3, 2, 5)
	result := difference(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[]")
}

@(test)
/// description = Difference (or Complement) of a set is a set of all elements that are only in the first set -> difference of a non-empty set and an empty set is the non-empty set
test_difference_or_complement_of_a_set_is_a_set_of_all_elements_that_are_only_in_the_first_set__difference_of_a_non_empty_set_and_an_empty_set_is_the_non_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 2, 3, 4)
	other := new_set()
	result := difference(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[1, 2, 3, 4]")
}

@(test)
/// description = Difference (or Complement) of a set is a set of all elements that are only in the first set -> difference of two non-empty sets is a set of elements that are only in the first set
test_difference_or_complement_of_a_set_is_a_set_of_all_elements_that_are_only_in_the_first_set__difference_of_two_non_empty_sets_is_a_set_of_elements_that_are_only_in_the_first_set :: proc(
	t: ^testing.T,
) {

	set := new_set(3, 2, 1)
	other := new_set(2, 4)
	result := difference(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[1, 3]")
}

@(test)
/// description = Difference (or Complement) of a set is a set of all elements that are only in the first set -> difference removes all duplicates in the first set
test_difference_or_complement_of_a_set_is_a_set_of_all_elements_that_are_only_in_the_first_set__difference_removes_all_duplicates_in_the_first_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 1)
	other := new_set(1)
	result := difference(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[]")
}

@(test)
/// description = Union returns a set of all elements in either set -> union of empty sets is an empty set
test_union_returns_a_set_of_all_elements_in_either_set__union_of_empty_sets_is_an_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set()
	result := join(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[]")
}

@(test)
/// description = Union returns a set of all elements in either set -> union of an empty set and non-empty set is the non-empty set
test_union_returns_a_set_of_all_elements_in_either_set__union_of_an_empty_set_and_non_empty_set_is_the_non_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set()
	other := new_set(2)
	result := join(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[2]")
}

@(test)
/// description = Union returns a set of all elements in either set -> union of a non-empty set and empty set is the non-empty set
test_union_returns_a_set_of_all_elements_in_either_set__union_of_a_non_empty_set_and_empty_set_is_the_non_empty_set :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 3)
	other := new_set()
	result := join(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[1, 3]")
}

@(test)
/// description = Union returns a set of all elements in either set -> union of non-empty sets contains all unique elements
test_union_returns_a_set_of_all_elements_in_either_set__union_of_non_empty_sets_contains_all_unique_elements :: proc(
	t: ^testing.T,
) {

	set := new_set(1, 3)
	other := new_set(2, 3)
	result := join(set, other)
	result_as_str := to_string(result)
	defer {
		delete(set)
		delete(other)
		delete(result)
		delete(result_as_str)
	}

	testing.expect_value(t, result_as_str, "[1, 2, 3]")
}
