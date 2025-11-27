package book_store

import "core:testing"

@(test)
test_only_a_single_book :: proc(t: ^testing.T) {
	basket := [?]u32{1}
	result := total(basket[:])
	expected: u32 = 800
	testing.expect_value(t, result, expected)
}

@(test)
test_two_of_the_same_book :: proc(t: ^testing.T) {
	basket := [?]u32{2, 2}
	result := total(basket[:])
	expected: u32 = 1600
	testing.expect_value(t, result, expected)
}

@(test)
test_empty_basket :: proc(t: ^testing.T) {
	basket := [?]u32{}
	result := total(basket[:])
	expected: u32 = 0
	testing.expect_value(t, result, expected)
}

@(test)
test_two_different_books :: proc(t: ^testing.T) {
	basket := [?]u32{1, 2}
	result := total(basket[:])
	expected: u32 = 1520
	testing.expect_value(t, result, expected)
}

@(test)
test_three_different_books :: proc(t: ^testing.T) {
	basket := [?]u32{1, 2, 3}
	result := total(basket[:])
	expected: u32 = 2160
	testing.expect_value(t, result, expected)
}

@(test)
test_four_different_books :: proc(t: ^testing.T) {
	basket := [?]u32{1, 2, 3, 4}
	result := total(basket[:])
	expected: u32 = 2560
	testing.expect_value(t, result, expected)
}

@(test)
test_five_different_books :: proc(t: ^testing.T) {
	basket := [?]u32{1, 2, 3, 4, 5}
	result := total(basket[:])
	expected: u32 = 3000
	testing.expect_value(t, result, expected)
}

@(test)
test_two_groups_of_four_is_cheaper_than_group_of_five_plus_group_of_three :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 5}
	result := total(basket[:])
	expected: u32 = 5120
	testing.expect_value(t, result, expected)
}

@(test)
test_two_groups_of_four_is_cheaper_than_groups_of_five_and_three :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 3, 4, 4, 5, 5}
	result := total(basket[:])
	expected: u32 = 5120
	testing.expect_value(t, result, expected)
}

@(test)
test_group_of_four_plus_group_of_two_is_cheaper_than_two_groups_of_three :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 4}
	result := total(basket[:])
	expected: u32 = 4080
	testing.expect_value(t, result, expected)
}

@(test)
test_two_each_of_first_four_books_and_one_copy_each_of_rest :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 4, 5}
	result := total(basket[:])
	expected: u32 = 5560
	testing.expect_value(t, result, expected)
}

@(test)
test_two_copies_of_each_book :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 4, 5, 5}
	result := total(basket[:])
	expected: u32 = 6000
	testing.expect_value(t, result, expected)
}

@(test)
test_three_copies_of_first_book_and_two_each_of_remaining :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1}
	result := total(basket[:])
	expected: u32 = 6800
	testing.expect_value(t, result, expected)
}

@(test)
test_three_each_of_first_two_books_and_two_each_of_remaining_books :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1, 2}
	result := total(basket[:])
	expected: u32 = 7520
	testing.expect_value(t, result, expected)
}

@(test)
test_four_groups_of_four_are_cheaper_than_two_groups_each_of_five_and_three :: proc(
	t: ^testing.T,
) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 5, 1, 1, 2, 2, 3, 3, 4, 5}
	result := total(basket[:])
	expected: u32 = 10240
	testing.expect_value(t, result, expected)
}

@(test)
test_check_that_groups_of_four_are_created_properly_even_when_there_are_more_groups_of_three_than_groups_of_five :: proc(
	t: ^testing.T,
) {
	basket := [?]u32{1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 5, 5}
	result := total(basket[:])
	expected: u32 = 14560
	testing.expect_value(t, result, expected)
}

@(test)
test_one_group_of_one_and_four_is_cheaper_than_one_group_of_two_and_three :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 3, 4}
	result := total(basket[:])
	expected: u32 = 3360
	testing.expect_value(t, result, expected)
}

@(test)
test_one_group_of_one_and_two_plus_three_groups_of_four_is_cheaper_than_one_group_of_each_size :: proc(
	t: ^testing.T,
) {
	basket := [?]u32{1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5}
	result := total(basket[:])
	expected: u32 = 10000
	testing.expect_value(t, result, expected)
}
