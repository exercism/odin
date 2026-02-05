package zipper

import "core:fmt"
import "core:strings"
import "core:testing"

@(test)
/// description = data is retained
test_data_is_retained :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	result := zip_to_tree(z1)
	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	expect_trees(t, result, input)
}

@(test)
/// description = left, right and value
test_left_right_and_value :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	z3 := zip_right(z2)
	result := zip_value(z3)

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	testing.expect_value(t, result, 3)
}

@(test)
/// description = dead end
test_dead_end :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	result := zip_left(z2)

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	testing.expectf(
		t,
		result.tree == nil,
		"expected zipper tree to be empty, got %s",
		tree_to_string(result.tree),
	)
}

@(test)
/// description = tree from deep focus
test_tree_from_deep_focus :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	z3 := zip_right(z2)
	result := zip_to_tree(z3)

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	expect_trees(t, result, input)
}

@(test)
/// description = traversing up from top
test_traversing_up_from_top :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	result := zip_up(z1)

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	testing.expectf(
		t,
		result.tree == nil,
		"expected zipper tree to be empty, got %s",
		tree_to_string(result.tree),
	)
}

@(test)
/// description = left, right, and up
test_left_right_and_up :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	z3 := zip_up(z2)
	z4 := zip_right(z3)
	z5 := zip_up(z4)
	z6 := zip_left(z5)
	z7 := zip_right(z6)
	result := zip_value(z7)

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	testing.expect_value(t, result, 3)
}

@(test)
/// description = test ability to descend multiple levels and return
test_test_ability_to_descend_multiple_levels_and_return :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	z3 := zip_right(z2)
	z4 := zip_up(z3)
	z5 := zip_up(z4)
	result := zip_value(z5)

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	testing.expect_value(t, result, 1)
}

@(test)
/// description = set_value
test_set_value :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	z3 := zip_set_value(z2, 5)
	result := zip_to_tree(z3)
	expected := _node(1, left = _node(5, right = _node(3)), right = _node(4))

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	expect_trees(t, result, expected)

}

@(test)
/// description = set_value after traversing up
test_set_value_after_traversing_up :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	z3 := zip_right(z2)
	z4 := zip_up(z3)
	z5 := zip_set_value(z4, 5)
	result := zip_to_tree(z5)
	expected := _node(1, left = _node(5, right = _node(3)), right = _node(4))

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	expect_trees(t, result, expected)
}

@(test)
/// description = set_left with leaf
test_set_left_with_leaf :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	z3 := zip_set_left(z2, _node(5))
	result := zip_to_tree(z3)
	expected := _node(1, left = _node(2, left = _node(5), right = _node(3)), right = _node(4))

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	expect_trees(t, result, expected)
}

@(test)
/// description = set_right with null
test_set_right_with_null :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	z3 := zip_set_right(z2, nil)
	result := zip_to_tree(z3)
	expected := _node(1, left = _node(2), right = _node(4))

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	expect_trees(t, result, expected)
}

@(test)
/// description = set_right with subtree
test_set_right_with_subtree :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_set_right(z1, _node(6, left = _node(7), right = _node(8)))
	result := zip_to_tree(z2)
	expected := _node(
		1,
		left = _node(2, right = _node(3)),
		right = _node(6, left = _node(7), right = _node(8)),
	)

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	expect_trees(t, result, expected)
}

@(test)
/// description = set_value on deep focus
test_set_value_on_deep_focus :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	z3 := zip_right(z2)
	z4 := zip_set_value(z3, 5)
	result := zip_to_tree(z4)
	expected := _node(1, left = _node(2, right = _node(5)), right = _node(4))

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	expect_trees(t, result, expected)
}

@(test)
/// description = different paths to same zipper
test_different_paths_to_same_zipper :: proc(t: ^testing.T) {

	ctx_allocator := context.allocator
	context.allocator = context.temp_allocator

	input := _node(1, left = _node(2, right = _node(3)), right = _node(4))
	z1 := zip_from_tree(input)
	z2 := zip_left(z1)
	z3 := zip_up(z2)
	result := zip_right(z3)
	initial_tree := zip_to_tree(result)

	defer {
		context.allocator = ctx_allocator
		free_all(context.temp_allocator)
	}
	expect_trees(t, initial_tree, input)
	expect_trees(t, result.tree, _node(4))
	if result.trail == nil { return }
	testing.expect_value(t, result.trail.value, 1)
	testing.expect_value(t, result.trail.action, Action.Right)
	testing.expect_value(t, result.trail.next, nil)
	expect_trees(t, result.trail.tree, _node(2, right = _node(3)))
}

// Helper function to convert a tree into a string format we can use
// to report errors to the student.
tree_to_string :: proc(t: Tree) -> string {

	// Recursively write nodes to a Builder.
	write_node :: proc(buf: ^strings.Builder, t: Tree) {

		strings.write_string(buf, "node(")
		strings.write_int(buf, t.value)
		if t.left != nil {
			strings.write_string(buf, ", left=")
			write_node(buf, t.left)
		}
		if t.right != nil {
			strings.write_string(buf, ", right=")
			write_node(buf, t.right)
		}
		strings.write_rune(buf, ')')
	}

	if t == nil { return fmt.aprintf("nil") }

	buf := strings.builder_make()
	write_node(&buf, t)
	return strings.to_string(buf)

}

// Helper function to compare trees and provide meaningful error messages.
expect_trees :: proc(t: ^testing.T, actual, expected: Tree, loc := #caller_location) {
	result := tree_to_string(actual)
	exp_str := tree_to_string(expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str, loc = loc)
}

// Helper function to build a tree node.
// This function is called `_node` instead of `node` not to conflict
// with the similar function used in the example solution and any potential
// use of the name node by the students.
_node :: proc(value: int, left: Tree = nil, right: Tree = nil) -> Tree {

	nd := new(Node)
	nd.value = value
	nd.left = left
	nd.right = right
	return nd
}
