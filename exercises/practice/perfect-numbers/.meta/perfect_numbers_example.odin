package perfect_numbers

import "core:math"

Classification :: enum {
	Perfect,
	Abundant,
	Deficient,
	Undefined,
}

// Returns the sum of the divisors of `number` (excluding `number` itself).
// For example, the aliquot sum of 15 is (1 + 3 + 5) = 9
aliquot_sum :: proc(number: uint) -> uint {
	if number <= 1 do return 0
	result: uint = 1
	for i in 2 ..= (number / 2) {
		if number % i == 0 do result += i
	}
	return result
}

// Returns whether `number` is less than, equal to, or greater than its aliquot sum.
// `ok` will be false if invalid input (i.e. 0) is provided.
classify :: proc(number: uint) -> Classification {
	using Classification
	if number == 0 do return Undefined
	sum := aliquot_sum(number)
	switch {
	case number < sum:
		return Abundant
	case number > sum:
		return Deficient
	case:
		return Perfect
	}
}
