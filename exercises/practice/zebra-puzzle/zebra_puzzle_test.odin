package zebra_puzzle

import "core:testing"

@(test)
test_resident_who_drinks_water :: proc(t: ^testing.T) {

	result := who_drinks_water()
	defer delete(result)

	testing.expect_value(t, result, "Norwegian")
}

@(test)
test_resident_who_owns_zebra :: proc(t: ^testing.T) {

	result := who_owns_the_zebra()
	defer delete(result)

	testing.expect_value(t, result, "Japanese")
}
