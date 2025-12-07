package linked_list

import "core:testing"

@(test)
/// description = popping empty list
test_popping_empty_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	_, error := pop(&list)
	testing.expect_value(t, error, Error.Empty_List)
}

@(test)
/// description = shifting empty list
test_shifting_empty_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	_, error := shift(&list)
	testing.expect_value(t, error, Error.Empty_List)
}

@(test)
/// description = pop gets element from the list
test_pop_gets_element_from_the_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 7)

	value, error := pop(&list)
	testing.expect_value(t, value, 7)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = push/pop respectively add/remove at the end of the list
test_pushpop_respectively_addremove_at_the_end_of_the_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 11)
	push(&list, 13)

	value, error := pop(&list)
	testing.expect_value(t, value, 13)
	testing.expect_value(t, error, Error.None)

	value, error = pop(&list)
	testing.expect_value(t, value, 11)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = shift gets an element from the list
test_shift_gets_an_element_from_the_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 17)

	value, error := shift(&list)
	testing.expect_value(t, value, 17)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = shift gets first element from the list
test_shift_gets_first_element_from_the_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 23)
	push(&list, 5)

	value, error := shift(&list)
	testing.expect_value(t, value, 23)
	testing.expect_value(t, error, Error.None)

	value, error = shift(&list)
	testing.expect_value(t, value, 5)
	testing.expect_value(t, error, Error.None)

}

@(test)
/// description = unshift adds element at start of the list
test_unshift_adds_element_at_start_of_the_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	unshift(&list, 23)
	unshift(&list, 5)

	value, error := shift(&list)
	testing.expect_value(t, value, 5)
	testing.expect_value(t, error, Error.None)

	value, error = shift(&list)
	testing.expect_value(t, value, 23)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = pop, push, shift, and unshift can be used in any order
test_pop_push_shift_and_unshift_can_be_used_in_any_order :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 1)
	push(&list, 2)

	value, error := pop(&list)
	testing.expect_value(t, value, 2)
	testing.expect_value(t, error, Error.None)

	push(&list, 3)

	value, error = shift(&list)
	testing.expect_value(t, value, 1)
	testing.expect_value(t, error, Error.None)

	unshift(&list, 4)
	push(&list, 5)

	value, error = shift(&list)
	testing.expect_value(t, value, 4)
	testing.expect_value(t, error, Error.None)

	value, error = pop(&list)
	testing.expect_value(t, value, 5)
	testing.expect_value(t, error, Error.None)

	value, error = shift(&list)
	testing.expect_value(t, value, 3)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = count an empty list
test_count_an_empty_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	testing.expect_value(t, count(list), 0)
}

@(test)
/// description = count a list with items
test_count_a_list_with_items :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 37)
	push(&list, 1)

	testing.expect_value(t, count(list), 2)
}

@(test)
/// description = count is correct after mutation
test_count_is_correct_after_mutation :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 31)

	testing.expect_value(t, count(list), 1)

	unshift(&list, 43)

	testing.expect_value(t, count(list), 2)

	_, _ = shift(&list)

	testing.expect_value(t, count(list), 1)

	_, _ = pop(&list)

	testing.expect_value(t, count(list), 0)
}

@(test)
/// description = popping to empty doesn't break the list
test_popping_to_empty_doesnt_break_the_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 41)
	push(&list, 59)
	_, _ = pop(&list)
	_, _ = pop(&list)
	push(&list, 47)

	testing.expect_value(t, count(list), 1)

	value, error := pop(&list)
	testing.expect_value(t, value, 47)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = shifting to empty doesn't break the list
test_shifting_to_empty_doesnt_break_the_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 41)
	push(&list, 59)
	_, _ = shift(&list)
	_, _ = shift(&list)
	push(&list, 47)

	testing.expect_value(t, count(list), 1)

	value, error := shift(&list)
	testing.expect_value(t, value, 47)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = deletes the only element
test_deletes_the_only_element :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 61)
	delete(&list, 61)

	testing.expect_value(t, count(list), 0)
}

@(test)
/// description = deletes the element with the specified value from the list
test_deletes_the_element_with_the_specified_value_from_the_list :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 71)
	push(&list, 83)
	push(&list, 79)
	delete(&list, 83)

	testing.expect_value(t, count(list), 2)

	value, error := pop(&list)
	testing.expect_value(t, value, 79)
	testing.expect_value(t, error, Error.None)

	value, error = shift(&list)
	testing.expect_value(t, value, 71)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = deletes the element with the specified value from the list, re-assigns tail
test_deletes_the_element_with_the_specified_value_from_the_list_re_assigns_tail :: proc(
	t: ^testing.T,
) {
	list := new_list()
	defer destroy_list(&list)

	push(&list, 71)
	push(&list, 83)
	push(&list, 79)
	delete(&list, 83)

	testing.expect_value(t, count(list), 2)

	value, error := pop(&list)
	testing.expect_value(t, value, 79)
	testing.expect_value(t, error, Error.None)

	value, error = pop(&list)
	testing.expect_value(t, value, 71)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = deletes the element with the specified value from the list, re-assigns head
test_deletes_the_element_with_the_specified_value_from_the_list_re_assigns_head :: proc(
	t: ^testing.T,
) {
	list := new_list()
	defer destroy_list(&list)

	push(&list, 71)
	push(&list, 83)
	push(&list, 79)
	delete(&list, 83)

	testing.expect_value(t, count(list), 2)

	value, error := shift(&list)
	testing.expect_value(t, value, 71)
	testing.expect_value(t, error, Error.None)

	value, error = shift(&list)
	testing.expect_value(t, value, 79)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = deletes the first of two elements
test_deletes_the_first_of_two_elements :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 97)
	push(&list, 101)
	delete(&list, 97)

	testing.expect_value(t, count(list), 1)

	value, error := pop(&list)
	testing.expect_value(t, value, 101)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = deletes the second of two elements
test_deletes_the_second_of_two_elements :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 97)
	push(&list, 101)
	delete(&list, 101)

	testing.expect_value(t, count(list), 1)

	value, error := pop(&list)
	testing.expect_value(t, value, 97)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = delete does not modify the list if the element is not found
test_delete_does_not_modify_the_list_if_the_element_is_not_found :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 89)
	delete(&list, 103)

	testing.expect_value(t, count(list), 1)
}

@(test)
/// description = deletes only the first occurrence
test_deletes_only_the_first_occurrence :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 73)
	push(&list, 9)
	push(&list, 9)
	push(&list, 107)
	delete(&list, 9)

	testing.expect_value(t, count(list), 3)

	value, error := pop(&list)
	testing.expect_value(t, value, 107)
	testing.expect_value(t, error, Error.None)

	value, error = pop(&list)
	testing.expect_value(t, value, 9)
	testing.expect_value(t, error, Error.None)

	value, error = pop(&list)
	testing.expect_value(t, value, 73)
	testing.expect_value(t, error, Error.None)
}

@(test)
/// description = reverses a list with three elements
test_reverses_a_list_with_three_elements :: proc(t: ^testing.T) {

	list := new_list()
	defer destroy_list(&list)

	push(&list, 50)
	push(&list, 60)
	push(&list, 70)
	reverse(&list)

	value, error := pop(&list)
	testing.expect_value(t, value, 50)
	testing.expect_value(t, error, Error.None)

	value, error = pop(&list)
	testing.expect_value(t, value, 60)
	testing.expect_value(t, error, Error.None)

	value, error = pop(&list)
	testing.expect_value(t, value, 70)
	testing.expect_value(t, error, Error.None)

	testing.expect_value(t, count(list), 0)
}

@(test)
/// description = reverses a list with two elements
test_reverses_a_list_with_two_elements :: proc(t: ^testing.T) {

	// Test the case where head and tail are neighbors.

	list := new_list()
	defer destroy_list(&list)

	push(&list, 50)
	push(&list, 60)
	reverse(&list)

	value, error := pop(&list)
	testing.expect_value(t, value, 50)
	testing.expect_value(t, error, Error.None)

	value, error = pop(&list)
	testing.expect_value(t, value, 60)
	testing.expect_value(t, error, Error.None)

	testing.expect_value(t, count(list), 0)
}

@(test)
/// description = reverses a list with one element
test_reverses_a_list_with_one_element :: proc(t: ^testing.T) {

	// Test the case where head and tail are collocated.

	list := new_list()
	defer destroy_list(&list)

	push(&list, 50)
	reverse(&list)

	value, error := pop(&list)
	testing.expect_value(t, value, 50)
	testing.expect_value(t, error, Error.None)

	testing.expect_value(t, count(list), 0)
}

@(test)
/// description = reverses a list with no element
test_reverses_a_list_with_no_element :: proc(t: ^testing.T) {

	// Test the case where head and tail are collocated.

	list := new_list()
	defer destroy_list(&list)

	reverse(&list)

	testing.expect_value(t, count(list), 0)
}
