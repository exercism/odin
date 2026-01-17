package expect_helpers

import "core:fmt"
import "core:testing"

// If you need to compare slices of strings, copy this procedure in your
// `<exercise_slug>_test.odin` and use `expect_strings()` to compare them.
// This function provides informative error reports.
expect_string_slices :: proc(t: ^testing.T, actual, expected: []string, loc := #caller_location) {
	result := fmt.aprintf("%s", actual)
	exp_str := fmt.aprintf("%s", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str, loc = loc)
}

// If you need to compare slices of any type but string, copy this procedure in your
// `<exercise_slug>_test.odin` and use `expect_slices()` to compare them.
// This function provides informative error reports.
expect_slices :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {
	result := fmt.aprintf("%v", actual)
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str, loc = loc)
}
