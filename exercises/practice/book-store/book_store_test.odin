package book_store

import "core:testing"

@(test)
/// description = Only a single book
test_only_a_single_book :: proc(t: ^testing.T) {
	basket := [?]u32{1}
	result := total(basket[:])
	expected: u32 = 800
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Two of the same book
test_two_of_the_same_book :: proc(t: ^testing.T) {
	basket := [?]u32{2, 2}
	result := total(basket[:])
	expected: u32 = 1600
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Empty basket
test_empty_basket :: proc(t: ^testing.T) {
	basket := [?]u32{}
	result := total(basket[:])
	expected: u32 = 0
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Two different books
test_two_different_books :: proc(t: ^testing.T) {
	basket := [?]u32{1, 2}
	result := total(basket[:])
	expected: u32 = 1520
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Three different books
test_three_different_books :: proc(t: ^testing.T) {
	basket := [?]u32{1, 2, 3}
	result := total(basket[:])
	expected: u32 = 2160
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Four different books
test_four_different_books :: proc(t: ^testing.T) {
	basket := [?]u32{1, 2, 3, 4}
	result := total(basket[:])
	expected: u32 = 2560
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Five different books
test_five_different_books :: proc(t: ^testing.T) {
	basket := [?]u32{1, 2, 3, 4, 5}
	result := total(basket[:])
	expected: u32 = 3000
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Two groups of four is cheaper than group of five plus group of three
test_two_groups_of_four_is_cheaper_than_group_of_five_plus_group_of_three :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 5}
	result := total(basket[:])
	expected: u32 = 5120
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Two groups of four is cheaper than groups of five and three
test_two_groups_of_four_is_cheaper_than_groups_of_five_and_three :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 3, 4, 4, 5, 5}
	result := total(basket[:])
	expected: u32 = 5120
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Group of four plus group of two is cheaper than two groups of three
test_group_of_four_plus_group_of_two_is_cheaper_than_two_groups_of_three :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 4}
	result := total(basket[:])
	expected: u32 = 4080
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Two each of first four books and one copy each of rest
test_two_each_of_first_four_books_and_one_copy_each_of_rest :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 4, 5}
	result := total(basket[:])
	expected: u32 = 5560
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Two copies of each book
test_two_copies_of_each_book :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 4, 5, 5}
	result := total(basket[:])
	expected: u32 = 6000
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Three copies of first book and two each of remaining
test_three_copies_of_first_book_and_two_each_of_remaining :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1}
	result := total(basket[:])
	expected: u32 = 6800
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Three each of first two books and two each of remaining books
test_three_each_of_first_two_books_and_two_each_of_remaining_books :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1, 2}
	result := total(basket[:])
	expected: u32 = 7520
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Four groups of four are cheaper than two groups each of five and three
test_four_groups_of_four_are_cheaper_than_two_groups_each_of_five_and_three :: proc(
	t: ^testing.T,
) {
	basket := [?]u32{1, 1, 2, 2, 3, 3, 4, 5, 1, 1, 2, 2, 3, 3, 4, 5}
	result := total(basket[:])
	expected: u32 = 10240
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Check that groups of four are created properly even when there are more groups of three than groups of five
test_check_that_groups_of_four_are_created_properly_even_when_there_are_more_groups_of_three_than_groups_of_five :: proc(
	t: ^testing.T,
) {
	basket := [?]u32{1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 5, 5}
	result := total(basket[:])
	expected: u32 = 14560
	testing.expect_value(t, result, expected)
}

@(test)
/// description = One group of one and four is cheaper than one group of two and three
test_one_group_of_one_and_four_is_cheaper_than_one_group_of_two_and_three :: proc(t: ^testing.T) {
	basket := [?]u32{1, 1, 2, 3, 4}
	result := total(basket[:])
	expected: u32 = 3360
	testing.expect_value(t, result, expected)
}

@(test)
/// description = One group of one and two plus three groups of four is cheaper than one group of each size
test_one_group_of_one_and_two_plus_three_groups_of_four_is_cheaper_than_one_group_of_each_size :: proc(
	t: ^testing.T,
) {
	basket := [?]u32{1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5}
	result := total(basket[:])
	expected: u32 = 10000
	testing.expect_value(t, result, expected)
}
