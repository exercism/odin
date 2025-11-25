package triangle

import "core:slice"

Error :: enum {
	None,
	Not_A_Triangle,
	Unimplemented,
}

is_equilateral :: proc(a: f64, b: f64, c: f64) -> (bool, Error) {
	if !is_valid(a, b, c) { return false, .Not_A_Triangle }

	return a == b && b == c, .None
}

is_isosceles :: proc(a: f64, b: f64, c: f64) -> (bool, Error) {
	if !is_valid(a, b, c) { return false, .Not_A_Triangle }

	return a == b || b == c || c == a, .None
}

is_scalene :: proc(a: f64, b: f64, c: f64) -> (bool, Error) {
	if !is_valid(a, b, c) { return false, .Not_A_Triangle }

	return a != b && b != c && c != a, .None
}

@(private = "file")
is_valid :: proc(sides: ..f64) -> bool {
	slice.sort(sides)
	return sides[0] > 0 && sides[0] + sides[1] > sides[2]
}
