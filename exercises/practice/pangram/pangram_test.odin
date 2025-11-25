package pangram

import "core:testing"

@(test)
test_sentence_empty :: proc(t: ^testing.T) {
	testing.expect(t, !is_pangram(""))
}

@(test)
test_pangram_with_only_lower_case :: proc(t: ^testing.T) {
	testing.expect(t, is_pangram("the quick brown fox jumps over the lazy dog"))
}

@(test)
test_missing_character_x :: proc(t: ^testing.T) {
	testing.expect(t, !is_pangram("a quick movement of the enemy will jeopardize five gunboats"))
}

@(test)
test_another_missing_character_x :: proc(t: ^testing.T) {
	testing.expect(t, !is_pangram("the quick brown fish jumps over the lazy dog"))
}

@(test)
test_pangram_with_underscores :: proc(t: ^testing.T) {
	testing.expect(t, is_pangram("the_quick_brown_fox_jumps_over_the_lazy_dog"))
}

@(test)
test_pangram_with_numbers :: proc(t: ^testing.T) {
	testing.expect(t, is_pangram("the 1 quick brown fox jumps over the 2 lazy dogs"))
}

@(test)
test_missing_letters_replaced_by_numbers :: proc(t: ^testing.T) {
	testing.expect(t, !is_pangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"))
}

@(test)
test_pangram_with_mixed_case_and_punctuation :: proc(t: ^testing.T) {
	testing.expect(t, is_pangram("\"Five quacking Zephyrs jolt my wax bed.\""))
}

@(test)
unique_26_characters_but_not_pangram :: proc(t: ^testing.T) {
	testing.expect(t, !is_pangram("abcdefghijklm ABCDEFGHIJKLM"))
}

@(test)
non_alphanumeric_printable :: proc(t: ^testing.T) {
	testing.expect(t, !is_pangram(" !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"))
}
