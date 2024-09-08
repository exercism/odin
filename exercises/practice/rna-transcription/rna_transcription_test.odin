/* These are the unit tests for the exercise. Only the first one is enabled to start with. You can
 * enable the other tests by uncommenting the `@(test)` attribute of the test procedure. Your
 * solution should pass all tests before it is ready for submission.
 */

package rna_transcription

import "core:mem"
import "core:testing"

@(test)
test_empty_rna_sequence :: proc(t: ^testing.T) {
	rna, ok := to_rna("")
	testing.expect_value(t, rna, "")
	testing.expect(t, ok)
}

// @(test)
test_rna_complement_of_cytosine_is_guanine :: proc(t: ^testing.T) {
	rna, ok := to_rna("C")
	testing.expect_value(t, rna, "G")
	testing.expect(t, ok)
}

// @(test)
test_rna_complement_of_guanine_is_cytosine :: proc(t: ^testing.T) {
	rna, ok := to_rna("G")
	testing.expect_value(t, rna, "C")
	testing.expect(t, ok)
}

// @(test)
test_rna_complement_of_thymine_is_adenine :: proc(t: ^testing.T) {
	rna, ok := to_rna("T")
	testing.expect_value(t, rna, "A")
	testing.expect(t, ok)
}

// @(test)
test_rna_complement_of_adenine_is_uracil :: proc(t: ^testing.T) {
	rna, ok := to_rna("A")
	testing.expect_value(t, rna, "U")
	testing.expect(t, ok)
}

// @(test)
test_rna_complement :: proc(t: ^testing.T) {
	rna, ok := to_rna("ACGTGGTCTTAA")
	testing.expect_value(t, rna, "UGCACCAGAAUU")
	testing.expect(t, ok)
}

// @(test)
test_no_memory_leaks :: proc(t: ^testing.T) {
	track: mem.Tracking_Allocator
	mem.tracking_allocator_init(&track, context.allocator)
	defer mem.tracking_allocator_destroy(&track)
	context.allocator = mem.tracking_allocator(&track)
	test_rna_complement(t)
	testing.expect_value(t, len(track.allocation_map), 0)
	testing.expect_value(t, len(track.bad_free_array), 0)
}
