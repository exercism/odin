package isbn_verifier

import "core:testing"

@(test)
test_valid_isbn :: proc(t: ^testing.T) {

	testing.expect(t, is_valid("3-598-21508-8"))
}

@(test)
test_invalid_isbn_check_digit :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3-598-21508-9"))
}

@(test)
test_valid_isbn_with_a_check_digit_of_10 :: proc(t: ^testing.T) {

	testing.expect(t, is_valid("3-598-21507-X"))

}

@(test)
test_check_digit_is_a_character_other_than_x :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3-598-21507-A"))
}

@(test)
test_invalid_check_digit_in_isbn_is_not_treated_as_zero :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("4-598-21507-B"))
}

@(test)
test_invalid_character_in_isbn_is_not_treated_as_zero :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3-598-P1581-X"))
}

@(test)
test_x_is_only_valid_as_a_check_digit :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3-598-2X507-9"))
}

@(test)
test_only_one_check_digit_is_allowed :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3-598-21508-96"))
}

@(test)
test_x_is_not_substituted_by_the_value_10 :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3-598-2X507-5"))
}

@(test)
test_valid_isbn_without_separating_dashes :: proc(t: ^testing.T) {

	testing.expect(t, is_valid("3598215088"))
}

@(test)
test_isbn_without_separating_dashes_and_x_as_check_digit :: proc(t: ^testing.T) {

	testing.expect(t, is_valid("359821507X"))
}

@(test)
test_isbn_without_check_digit_and_dashes :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("359821507"))
}
@(test)
test_too_long_isbn_and_no_dashes :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3598215078X"))
}

@(test)
test_too_short_isbn :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("00"))
}

@(test)
test_isbn_without_check_digit :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3-598-21507"))
}

@(test)
test_check_digit_of_x_should_not_be_used_for_0 :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3-598-21515-X"))
}

@(test)
test_empty_isbn :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid(""))
}

@(test)
test_input_is_9_characters :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("134456729"))
}

@(test)
test_invalid_characters_are_not_ignored_after_checking_length :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3132P34035"))
}

@(test)
test_invalid_characters_are_not_ignored_before_checking_length :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("3598P215088"))
}

@(test)
test_input_is_too_long_but_contains_a_valid_isbn :: proc(t: ^testing.T) {

	testing.expect(t, !is_valid("98245726788"))
}
