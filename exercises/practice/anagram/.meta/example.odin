package anagram

import "core:slice"
import "core:strings"
import "core:unicode/utf8"

find_anagrams :: proc(word: string, candidates: []string) -> []string {

	anagrams := make([dynamic]string, 0, len(candidates))
	word_letters := letters_in_order(word)
	defer delete(word_letters)
	lc_word := strings.to_lower(word)
	defer delete(lc_word)

	for candidate in candidates {

		lc_candidate := strings.to_lower(candidate)
		defer delete(lc_candidate)
		if lc_word == lc_candidate { continue }

		candidate_letters := letters_in_order(candidate)
		defer delete(candidate_letters)
		if word != candidate && slice.equal(word_letters, candidate_letters) {
			append(&anagrams, candidate)
		}
	}
	return anagrams[:]
}

letters_in_order :: proc(word: string) -> []rune {

	lc_word := strings.to_lower(word)
	defer delete(lc_word)
	letters := utf8.string_to_runes(lc_word)
	slice.sort(letters)
	return letters
}
