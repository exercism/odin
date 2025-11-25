package triangle

Error :: enum {
	None,
	Not_A_Triangle,
	Unimplemented,
}

is_equilateral :: proc(a: f64, b: f64, c: f64) -> (bool, Error) {
	// Implement the `is_equilateral` procedure
	return false, .Unimplemented
}

is_isosceles :: proc(a: f64, b: f64, c: f64) -> (bool, Error) {
	// Implement the `is_isosceles` procedure
	return false, .Unimplemented
}

is_scalene :: proc(a: f64, b: f64, c: f64) -> (bool, Error) {
	// Implement the `is_scalene` procedure
	return false, .Unimplemented
}
