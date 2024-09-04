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
}

value :: proc(colors: []Color) -> (int, Error) {
	if len(colors) < 2 do return 0, .TooFewColors
	else do return int(colors[0]) * 10 + int(colors[1]), .None
}
