package tagfixer

import "core:testing"

@(test)
test_snake_case__plain :: proc(t: ^testing.T) {

	result := to_snake_case("This Is a Plain Title")
	testing.expect_value(t, result, "this_is_a_plain_title")
}

@(test)
test_snake_case__plain_extra_spaces :: proc(t: ^testing.T) {

	result := to_snake_case("This Is a Plain   Title")
	testing.expect_value(t, result, "this_is_a_plain___title")
}

@(test)
test_snake_case__camel_case :: proc(t: ^testing.T) {

	result := to_snake_case("This is a text with SomeCamelCase1Of7")
	testing.expect_value(t, result, "this_is_a_text_with_some_camel_case1_of7")
}

@(test)
test_snake_case__special_chars :: proc(t: ^testing.T) {

	result := to_snake_case("It's a Beautiful Day!")
	testing.expect_value(t, result, "its_a_beautiful_day")
}

@(test)
test_snake_case__real_example :: proc(t: ^testing.T) {

	result := to_snake_case("Arithmetic: Addition: Add two positive rational numbers")
	testing.expect_value(t, result, "arithmetic__addition__add_two_positive_rational_numbers")
}

@(test)
test_snake_case__dash_and_underscore :: proc(t: ^testing.T) {

	result := to_snake_case("When it rains - it rains - really_not")
	testing.expect_value(t, result, "when_it_rains___it_rains___really_not")
}

@(test)
test_snake_case__empty_string :: proc(t: ^testing.T) {

	result := to_snake_case("")
	testing.expect_value(t, result, "")
}

@(test)
test_rebuild_english__plain_text :: proc(t: ^testing.T) {

	result := rebuild_english("a_beautiful_world")
	testing.expect_value(t, result, "A beautiful world")
}

@(test)
test_rebuild_english__empty_string :: proc(t: ^testing.T) {

	result := rebuild_english("")
	testing.expect_value(t, result, "")
}

@(test)
test_rebuild_english__one_letter_string :: proc(t: ^testing.T) {

	result := rebuild_english("a")
	testing.expect_value(t, result, "A")
}
