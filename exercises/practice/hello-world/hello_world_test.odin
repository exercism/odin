package hello_world

import "core:testing"

@(test)
say_hi :: proc(t: ^testing.T) {
	expected := "Hello, World!"

	testing.expect_value(t, hello_world(), expected)
}
