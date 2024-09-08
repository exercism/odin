/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package raindrops

import "core:mem"
import "core:testing"

@(test)
test_the_sound_for_1_is_1 :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(1), "1")
}

// @(test)
test_the_sound_for_3_is_pling :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(3), "Pling")
}

// @(test)
test_the_sound_for_5_is_plang :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(5), "Plang")
}

// @(test)
test_the_sound_for_7_is_plong :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(7), "Plong")
}

// @(test)
test_the_sound_for_6_is_pling :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(6), "Pling")
}

// @(test)
test_the_sound_for_8_is_8 :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(8), "8")
}

// @(test)
test_the_sound_for_9_is_pling :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(9), "Pling")
}

// @(test)
test_the_sound_for_10_is_plang :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(10), "Plang")
}

// @(test)
test_the_sound_for_14_is_plong :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(14), "Plong")
}

// @(test)
test_the_sound_for_15_is_plingplang :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(15), "PlingPlang")
}

// @(test)
test_the_sound_for_21_is_plingplong :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(21), "PlingPlong")
}

// @(test)
test_the_sound_for_25_is_plang :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(25), "Plang")
}

// @(test)
test_the_sound_for_27_is_pling :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(27), "Pling")
}

// @(test)
test_the_sound_for_35_is_plangplong :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(35), "PlangPlong")
}

// @(test)
test_the_sound_for_49_is_plong :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(49), "Plong")
}

// @(test)
test_the_sound_for_52_is_52 :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(52), "52")
}

// @(test)
test_the_sound_for_105_is_plingplangplong :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(105), "PlingPlangPlong")
}

// @(test)
test_the_sound_for_3125_is_plang :: proc(t: ^testing.T) {
	testing.expect_value(t, convert(3125), "Plang")
}

// @(test)
test_no_memory_leaks :: proc(t: ^testing.T) {
	track: mem.Tracking_Allocator
	mem.tracking_allocator_init(&track, context.allocator)
	defer mem.tracking_allocator_destroy(&track)
	context.allocator = mem.tracking_allocator(&track)
	test_the_sound_for_105_is_plingplangplong(t)
	testing.expect_value(t, len(track.allocation_map), 0)
	testing.expect_value(t, len(track.bad_free_array), 0)
}
