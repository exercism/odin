package proverb

import "core:slice"
import "core:testing"

@(test)
test_zero_pieces :: proc(t: ^testing.T) {
	input := []string{}
	expected := []string{}

	testing.expect(t, slice.equal(recite(input), expected))
}

@(test)
test_one_piece :: proc(t: ^testing.T) {
	input := []string{"nail"}
	expected := []string{"And all for the want of a nail."}

	testing.expect(t, slice.equal(recite(input), expected))
}

@(test)
test_two_pieces :: proc(t: ^testing.T) {
	input := []string{"nail", "shoe"}
	expected := []string {
		"For want of a nail the shoe was lost.",
		"And all for the want of a nail.",
	}

	testing.expect(t, slice.equal(recite(input), expected))
}

@(test)
test_three_pieces :: proc(t: ^testing.T) {
	input := []string{"nail", "shoe", "horse"}
	expected := []string {
		"For want of a nail the shoe was lost.",
		"For want of a shoe the horse was lost.",
		"And all for the want of a nail.",
	}

	testing.expect(t, slice.equal(recite(input), expected))
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

	testing.expect(t, slice.equal(recite(input), expected))
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

	testing.expect(t, slice.equal(recite(input), expected))
}
