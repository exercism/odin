package resistor_color_duo

Color :: enum {
	Black,
	Brown,
	Red,
	Orange,
	Yellow,
	Green,
	Blue,
	Violet,
	Grey,
	White,
}

Error :: enum {
	None,
	TooFewColors,
	Unimplemented,
}

value :: proc(colors: []Color) -> (int, Error) {
	// Implement the procedure.
	return 0, .Unimplemented
}
