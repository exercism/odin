package hello_world

import "core:testing"

@(test)
test :: proc(t: ^testing.T) {
	expected := "Hello, World!"

	testing.expect_value(t, hello_world(), expected)
}
