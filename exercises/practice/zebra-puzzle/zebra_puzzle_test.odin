package zebra_puzzle

import "core:testing"

@(test)
/// description = resident who drinks water
test_resident_who_drinks_water :: proc(t: ^testing.T) {

	result := who_drinks_water()
	defer delete(result)

	testing.expect_value(t, result, "Norwegian")
}

@(test)
/// description = resident who owns zebra
test_resident_who_owns_zebra :: proc(t: ^testing.T) {

	result := who_owns_the_zebra()
	defer delete(result)

	testing.expect_value(t, result, "Japanese")
}
