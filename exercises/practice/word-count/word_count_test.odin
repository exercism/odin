package word_count

import "core:testing"

delete_map_and_key :: proc(m: map[string]$T) {
	for k in m {
		delete(k)
	}
	delete(m)
}

@(test)
/// description = count one word
test_count_one_word :: proc(t: ^testing.T) {
	input := "word"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 1)
	testing.expect_value(t, word_counts["word"], 1)
}

@(test)
/// description = count one of each word
test_count_one_of_each_word :: proc(t: ^testing.T) {
	input := "one of each"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 3)
	testing.expect_value(t, word_counts["one"], 1)
	testing.expect_value(t, word_counts["of"], 1)
	testing.expect_value(t, word_counts["each"], 1)
}

@(test)
/// description = multiple occurrences of a word
test_multiple_occurrences_of_a_word :: proc(t: ^testing.T) {
	input := "one fish two fish red fish blue fish"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 5)
	testing.expect_value(t, word_counts["one"], 1)
	testing.expect_value(t, word_counts["fish"], 4)
	testing.expect_value(t, word_counts["two"], 1)
	testing.expect_value(t, word_counts["red"], 1)
	testing.expect_value(t, word_counts["blue"], 1)
}

@(test)
/// description = handles cramped lists
test_handles_cramped_lists :: proc(t: ^testing.T) {
	input := "one,two,three"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 3)
	testing.expect_value(t, word_counts["one"], 1)
	testing.expect_value(t, word_counts["two"], 1)
	testing.expect_value(t, word_counts["three"], 1)
}

@(test)
/// description = handles expanded lists
test_handles_expanded_lists :: proc(t: ^testing.T) {
	input := "one,\ntwo,\nthree"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 3)
	testing.expect_value(t, word_counts["one"], 1)
	testing.expect_value(t, word_counts["two"], 1)
	testing.expect_value(t, word_counts["three"], 1)
}

@(test)
/// description = ignore punctuation
test_ignore_punctuation :: proc(t: ^testing.T) {
	input := "car: carpet as java: javascript!!&@$%^&"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 5)
	testing.expect_value(t, word_counts["car"], 1)
	testing.expect_value(t, word_counts["carpet"], 1)
	testing.expect_value(t, word_counts["as"], 1)
	testing.expect_value(t, word_counts["java"], 1)
	testing.expect_value(t, word_counts["javascript"], 1)
}

@(test)
/// description = include numbers
test_include_numbers :: proc(t: ^testing.T) {
	input := "testing, 1, 2 testing"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 3)
	testing.expect_value(t, word_counts["testing"], 2)
	testing.expect_value(t, word_counts["1"], 1)
	testing.expect_value(t, word_counts["2"], 1)
}

@(test)
/// description = normalize case
test_normalize_case :: proc(t: ^testing.T) {
	input := "go Go GO Stop stop"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 2)
	testing.expect_value(t, word_counts["go"], 3)
	testing.expect_value(t, word_counts["stop"], 2)
}

@(test)
/// description = with apostrophes
test_with_apostrophes :: proc(t: ^testing.T) {
	input := "'First: don't laugh. Then: don't cry. You're getting it.'"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 8)
	testing.expect_value(t, word_counts["first"], 1)
	testing.expect_value(t, word_counts["don't"], 2)
	testing.expect_value(t, word_counts["laugh"], 1)
	testing.expect_value(t, word_counts["then"], 1)
	testing.expect_value(t, word_counts["cry"], 1)
	testing.expect_value(t, word_counts["you're"], 1)
	testing.expect_value(t, word_counts["getting"], 1)
	testing.expect_value(t, word_counts["it"], 1)
}

@(test)
/// description = with quotations
test_with_quotations :: proc(t: ^testing.T) {
	input := "Joe can't tell between 'large' and large."
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 6)
	testing.expect_value(t, word_counts["joe"], 1)
	testing.expect_value(t, word_counts["can't"], 1)
	testing.expect_value(t, word_counts["tell"], 1)
	testing.expect_value(t, word_counts["between"], 1)
	testing.expect_value(t, word_counts["large"], 2)
	testing.expect_value(t, word_counts["and"], 1)
}

@(test)
/// description = substrings from the beginning
test_substrings_from_the_beginning :: proc(t: ^testing.T) {
	input := "Joe can't tell between app, apple and a."
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 8)
	testing.expect_value(t, word_counts["joe"], 1)
	testing.expect_value(t, word_counts["can't"], 1)
	testing.expect_value(t, word_counts["tell"], 1)
	testing.expect_value(t, word_counts["between"], 1)
	testing.expect_value(t, word_counts["app"], 1)
	testing.expect_value(t, word_counts["apple"], 1)
	testing.expect_value(t, word_counts["and"], 1)
	testing.expect_value(t, word_counts["a"], 1)
}

@(test)
/// description = multiple spaces not detected as a word
test_multiple_spaces_not_detected_as_a_word :: proc(t: ^testing.T) {
	input := " multiple   whitespaces"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 2)
	testing.expect_value(t, word_counts["multiple"], 1)
	testing.expect_value(t, word_counts["whitespaces"], 1)
}

@(test)
/// description = alternating word separators not detected as a word
test_alternating_word_separators_not_detected_as_a_word :: proc(t: ^testing.T) {
	input := ",\n,one,\n ,two \n 'three'"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 3)
	testing.expect_value(t, word_counts["one"], 1)
	testing.expect_value(t, word_counts["two"], 1)
	testing.expect_value(t, word_counts["three"], 1)
}

@(test)
/// description = quotation for word with apostrophe
test_quotation_for_word_with_apostrophe :: proc(t: ^testing.T) {
	input := "can, can't, 'can't'"
	word_counts := count_word(input)
	defer delete_map_and_key(word_counts)
	testing.expect_value(t, len(word_counts), 2)
	testing.expect_value(t, word_counts["can"], 1)
	testing.expect_value(t, word_counts["can't"], 2)
}
