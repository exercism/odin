package two_fer

import "core:testing"

@(test)
/// description = no name given
test_no_name_given :: proc(t: ^testing.T) {
	str := two_fer()
	defer delete(str)
	testing.expect_value(t, str, "One for you, one for me.")
}

@(test)
/// description = a name given
test_a_name_given :: proc(t: ^testing.T) {
	str := two_fer("Alice")
	defer delete(str)
	testing.expect_value(t, str, "One for Alice, one for me.")
}

@(test)
/// description = another name given
test_another_name_given :: proc(t: ^testing.T) {
	str := two_fer("Bob")
	defer delete(str)
	testing.expect_value(t, str, "One for Bob, one for me.")
}
