package two_fer

import "core:testing"

@(test)
test_no_name_given :: proc(t: ^testing.T) {
	expected := "One for you, one for me."

	testing.expect_value(t, two_fer(), expected)
}
@(test)
test_a_name_given :: proc(t: ^testing.T) {
	expected := "One for Alice, one for me."

	testing.expect_value(t, two_fer("Alice"), expected)
}

@(test)
test_another_name_given :: proc(t: ^testing.T) {
	expected := "One for Bob, one for me."

	testing.expect_value(t, two_fer("Bob"), expected)
}
