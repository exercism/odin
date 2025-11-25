package proverb

import "core:fmt"
import "core:testing"

/* ------------------------------------------------------------
 * A helper procedure to enable more helpful test failure output.
 * Stringify the slices and compare the strings.
 * If they don't match, the user will see the values.
 */
expect_slices_match :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {
	result := fmt.aprintf("%v", actual) // this varname shows up in the test output
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str)
}

// ------------------------------------------------------------
@(test)
test_zero_pieces :: proc(t: ^testing.T) {
	expected := []string{}
	input := []string{}

	result := recite(input)

	/* Your solution will need to allocate a slice and some strings.
     * We'll need to delete all the strings, then delete the slice.
     */
	defer {
		for s in result { delete(s) }
		delete(result)
	}

	expect_slices_match(t, result, expected)
}

@(test)
test_one_piece :: proc(t: ^testing.T) {
	input := []string{"nail"}
	expected := []string{"And all for the want of a nail."}

	result := recite(input)
	defer {
		for elem in result { delete(elem) }
		delete(result)
	}

	expect_slices_match(t, result, expected)
}

@(test)
test_two_pieces :: proc(t: ^testing.T) {
	input := []string{"nail", "shoe"}
	expected := []string {
		"For want of a nail the shoe was lost.",
		"And all for the want of a nail.",
	}

	result := recite(input)
	defer {
		for s in result { delete(s) }
		delete(result)
	}

	expect_slices_match(t, result, expected)
}

@(test)
test_three_pieces :: proc(t: ^testing.T) {
	input := []string{"nail", "shoe", "horse"}
	expected := []string {
		"For want of a nail the shoe was lost.",
		"For want of a shoe the horse was lost.",
		"And all for the want of a nail.",
	}

	result := recite(input)
	defer {
		for s in result { delete(s) }
		delete(result)
	}

	expect_slices_match(t, result, expected)
}

@(test)
test_full_proverb :: proc(t: ^testing.T) {
	input := []string{"nail", "shoe", "horse", "rider", "message", "battle", "kingdom"}
	expected := []string {
		"For want of a nail the shoe was lost.",
		"For want of a shoe the horse was lost.",
		"For want of a horse the rider was lost.",
		"For want of a rider the message was lost.",
		"For want of a message the battle was lost.",
		"For want of a battle the kingdom was lost.",
		"And all for the want of a nail.",
	}

	result := recite(input)
	defer {
		for s in result { delete(s) }
		delete(result)
	}

	expect_slices_match(t, result, expected)
}

@(test)
test_four_pieces_modernized :: proc(t: ^testing.T) {
	input := []string{"pin", "gun", "soldier", "battle"}
	expected := []string {
		"For want of a pin the gun was lost.",
		"For want of a gun the soldier was lost.",
		"For want of a soldier the battle was lost.",
		"And all for the want of a pin.",
	}

	result := recite(input)
	defer {
		for s in result { delete(s) }
		delete(result)
	}

	expect_slices_match(t, result, expected)
}
