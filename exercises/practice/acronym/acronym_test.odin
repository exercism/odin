package acronym

import "core:testing"

@(test)
/// description = basic
test_basic :: proc(t: ^testing.T) {

	expected := "PNG"
	input := "Portable Network Graphics"
	result := abbreviate(input)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = lowercase words
test_lowercase_words :: proc(t: ^testing.T) {

	expected := "ROR"
	input := "Ruby on Rails"
	result := abbreviate(input)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = punctuation
test_punctuation :: proc(t: ^testing.T) {

	expected := "FIFO"
	input := "First In, First Out"
	result := abbreviate(input)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = all caps word
test_all_caps_word :: proc(t: ^testing.T) {

	expected := "GIMP"
	input := "GNU Image Manipulation Program"
	result := abbreviate(input)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = punctuation without whitespace
test_punctuation_without_whitespace :: proc(t: ^testing.T) {

	expected := "CMOS"
	input := "Complementary metal-oxide semiconductor"
	result := abbreviate(input)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = very long abbreviation
test_very_long_abbreviation :: proc(t: ^testing.T) {

	expected := "ROTFLSHTMDCOALM"
	input := "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"
	result := abbreviate(input)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = consecutive delimiters
test_consecutive_delimiters :: proc(t: ^testing.T) {

	expected := "SIMUFTA"
	input := "Something - I made up from thin air"
	result := abbreviate(input)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = apostrophes
test_apostrophes :: proc(t: ^testing.T) {

	expected := "HC"
	input := "Halley's Comet"
	result := abbreviate(input)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = underscore emphasis
test_underscore_emphasis :: proc(t: ^testing.T) {

	expected := "TRNT"
	input := "The Road _Not_ Taken"
	result := abbreviate(input)
	defer delete(result)

	testing.expect_value(t, result, expected)
}
