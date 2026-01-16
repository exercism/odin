package anagram

import "core:fmt"
import "core:testing"

expect_slices_match :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {
	result := fmt.aprintf("%v", actual)
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}
	testing.expect_value(t, result, exp_str, loc = loc)
}

@(test)
/// description = no matches
test_no_matches :: proc(t: ^testing.T) {

	expected := [?]string{}
	word := "diaper"
	candidates := [?]string{"hello", "world", "zombies", "pants"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = detects two anagrams
test_detects_two_anagrams :: proc(t: ^testing.T) {

	expected := [?]string{"lemons", "melons"}
	word := "solemn"
	candidates := [?]string{"lemons", "cherry", "melons"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = does not detect anagram subsets
test_does_not_detect_anagram_subsets :: proc(t: ^testing.T) {

	expected := [?]string{}
	word := "good"
	candidates := [?]string{"dog", "goody"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = detects anagram
test_detects_anagram :: proc(t: ^testing.T) {

	expected := [?]string{"inlets"}
	word := "listen"
	candidates := [?]string{"enlists", "google", "inlets", "banana"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = detects three anagrams
test_detects_three_anagrams :: proc(t: ^testing.T) {

	expected := [?]string{"gallery", "regally", "largely"}
	word := "allergy"
	candidates := [?]string{"gallery", "ballerina", "regally", "clergy", "largely", "leading"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = detects multiple anagrams with different case
test_detects_multiple_anagrams_with_different_case :: proc(t: ^testing.T) {

	expected := [?]string{"Eons", "ONES"}
	word := "nose"
	candidates := [?]string{"Eons", "ONES"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = does not detect non-anagrams with identical checksum
test_does_not_detect_non_anagrams_with_identical_checksum :: proc(t: ^testing.T) {

	expected := [?]string{}
	word := "mass"
	candidates := [?]string{"last"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = detects anagrams case-insensitively
test_detects_anagrams_case_insensitively :: proc(t: ^testing.T) {

	expected := [?]string{"Carthorse"}
	word := "Orchestra"
	candidates := [?]string{"cashregister", "Carthorse", "radishes"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = detects anagrams using case-insensitive subject
test_detects_anagrams_using_case_insensitive_subject :: proc(t: ^testing.T) {

	expected := [?]string{"carthorse"}
	word := "Orchestra"
	candidates := [?]string{"cashregister", "carthorse", "radishes"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = detects anagrams using case-insensitive possible matches
test_detects_anagrams_using_case_insensitive_possible_matches :: proc(t: ^testing.T) {

	expected := [?]string{"Carthorse"}
	word := "orchestra"
	candidates := [?]string{"cashregister", "Carthorse", "radishes"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = does not detect an anagram if the original word is repeated
test_does_not_detect_an_anagram_if_the_original_word_is_repeated :: proc(t: ^testing.T) {

	expected := [?]string{}
	word := "go"
	candidates := [?]string{"goGoGO"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = anagrams must use all letters exactly once
test_anagrams_must_use_all_letters_exactly_once :: proc(t: ^testing.T) {

	expected := [?]string{}
	word := "tapper"
	candidates := [?]string{"patter"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = words are not anagrams of themselves
test_words_are_not_anagrams_of_themselves :: proc(t: ^testing.T) {

	expected := [?]string{}
	word := "BANANA"
	candidates := [?]string{"BANANA"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = words are not anagrams of themselves even if letter case is partially different
test_words_are_not_anagrams_of_themselves_even_if_letter_case_is_partially_different :: proc(
	t: ^testing.T,
) {

	expected := [?]string{}
	word := "BANANA"
	candidates := [?]string{"Banana"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = words are not anagrams of themselves even if letter case is completely different
test_words_are_not_anagrams_of_themselves_even_if_letter_case_is_completely_different :: proc(
	t: ^testing.T,
) {

	expected := [?]string{}
	word := "BANANA"
	candidates := [?]string{"banana"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = words other than themselves can be anagrams
test_words_other_than_themselves_can_be_anagrams :: proc(t: ^testing.T) {

	expected := [?]string{"Silent"}
	word := "LISTEN"
	candidates := [?]string{"LISTEN", "Silent"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = handles case of greek letters
test_handles_case_of_greek_letters :: proc(t: ^testing.T) {

	expected := [?]string{"ΒΓΑ", "γβα"}
	word := "ΑΒΓ"
	candidates := [?]string{"ΒΓΑ", "ΒΓΔ", "γβα", "αβγ"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = different characters may have the same bytes
test_different_characters_may_have_the_same_bytes :: proc(t: ^testing.T) {

	expected := [?]string{}
	word := "a⬂"
	candidates := [?]string{"€a"}
	result := find_anagrams(word, candidates[:])
	defer delete(result)

	expect_slices_match(t, result, expected[:])
}
