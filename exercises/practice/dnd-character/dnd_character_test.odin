/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package dnd_character

import "core:mem"
import "core:testing"

FUZZ_ITERATIONS :: 20

@(test)
test_ability_modifier_for_score_3_is_minus_4 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(3), -4)
}

// @(test)
test_ability_modifier_for_score_4_is_minus_3 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(4), -3)
}

// @(test)
test_ability_modifier_for_score_5_is_minus_3 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(5), -3)
}

// @(test)
test_ability_modifier_for_score_6_is_minus_2 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(6), -2)
}

// @(test)
test_ability_modifier_for_score_7_is_minus_2 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(7), -2)
}

// @(test)
test_ability_modifier_for_score_8_is_minus_1 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(8), -1)
}

// @(test)
test_ability_modifier_for_score_9_is_minus_1 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(9), -1)
}

// @(test)
test_ability_modifier_for_score_10_is_0 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(10), 0)
}

// @(test)
test_ability_modifier_for_score_11_is_0 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(11), 0)
}

// @(test)
test_ability_modifier_for_score_12_is_plus_1 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(12), 1)
}

// @(test)
test_ability_modifier_for_score_13_is_plus_1 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(13), 1)
}

// @(test)
test_ability_modifier_for_score_14_is_plus_2 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(14), 2)
}

// @(test)
test_ability_modifier_for_score_15_is_plus_2 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(15), 2)
}

// @(test)
test_ability_modifier_for_score_16_is_plus_3 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(16), 3)
}

// @(test)
test_ability_modifier_for_score_17_is_plus_3 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(17), 3)
}

// @(test)
test_ability_modifier_for_score_18_is_plus_4 :: proc(t: ^testing.T) {
	testing.expect_value(t, modifier(18), 4)
}

// @(test)
test_random_ability_is_within_range :: proc(t: ^testing.T) {
	for _ in 0 ..< FUZZ_ITERATIONS {
		a := ability()
		testing.expect(t, a >= 3 && a <= 18)
	}
}

// @(test)
test_random_character_is_valid :: proc(t: ^testing.T) {
	for _ in 0 ..< FUZZ_ITERATIONS {
		c := character()
		testing.expect(t, c.strength >= 3 && c.strength <= 18)
		testing.expect(t, c.dexterity >= 3 && c.dexterity <= 18)
		testing.expect(t, c.constitution >= 3 && c.constitution <= 18)
		testing.expect(t, c.intelligence >= 3 && c.intelligence <= 18)
		testing.expect(t, c.wisdom >= 3 && c.wisdom <= 18)
		testing.expect(t, c.charisma >= 3 && c.charisma <= 18)
		testing.expect_value(t, c.hitpoints, 10 + modifier(c.constitution))
	}
}

// @(test)
test_no_memory_leaks :: proc(t: ^testing.T) {
	track: mem.Tracking_Allocator
	mem.tracking_allocator_init(&track, context.allocator)
	defer mem.tracking_allocator_destroy(&track)
	context.allocator = mem.tracking_allocator(&track)
	test_random_character_is_valid(t)
	testing.expect_value(t, len(track.allocation_map), 0)
	testing.expect_value(t, len(track.bad_free_array), 0)
}
