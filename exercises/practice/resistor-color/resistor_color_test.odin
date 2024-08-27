package resistor_color

import "core:testing"

@(test)
black :: proc(t: ^testing.T) {
	testing.expect_value(t, code(.Black), 0)
}

@(test)
brown :: proc(t: ^testing.T) {
	testing.expect_value(t, code(.Brown), 1)
}

@(test)
red :: proc(t: ^testing.T) {
	testing.expect_value(t, code(.Red), 2)
}

@(test)
orange :: proc(t: ^testing.T) {
	testing.expect_value(t, code(.Orange), 3)
}

@(test)
yellow :: proc(t: ^testing.T) {
	testing.expect_value(t, code(.Yellow), 4)
}

@(test)
green :: proc(t: ^testing.T) {
	testing.expect_value(t, code(.Green), 5)
}

@(test)
blue :: proc(t: ^testing.T) {
	testing.expect_value(t, code(.Blue), 6)
}

@(test)
violet :: proc(t: ^testing.T) {
	testing.expect_value(t, code(.Violet), 7)
}

@(test)
grey :: proc(t: ^testing.T) {
	testing.expect_value(t, code(.Grey), 8)
}

@(test)
white :: proc(t: ^testing.T) {
	testing.expect_value(t, code(.White), 9)
}

@(test)
all_colors :: proc(t: ^testing.T) {
	testing.expect_value(
		t,
		colors(),
		[10]Color {
			.Black,
			.Brown,
			.Red,
			.Orange,
			.Yellow,
			.Green,
			.Blue,
			.Violet,
			.Grey,
			.White,
		},
	)
}
