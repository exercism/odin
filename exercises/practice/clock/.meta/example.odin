package clock

import "core:fmt"

// Implement this struct
Clock :: struct {
	mins: int,
}

MINS_PER_DAY :: 24 * 60

create_clock :: proc(hour, minute: int) -> Clock {
	return Clock{normalize(60 * hour + minute)}
}

@(private)
normalize :: proc(minutes: int) -> int {
	return minutes %% MINS_PER_DAY
}

to_string :: proc(clock: Clock) -> string {
	h, m := clock.mins / 60, clock.mins % 60
	return fmt.aprintf("%02d:%02d", h, m)
}

add :: proc(clock: ^Clock, minutes: int) {
	clock.mins = normalize(clock.mins + minutes)
}

subtract :: proc(clock: ^Clock, minutes: int) {
	add(clock, -minutes)
}

equals :: proc(clock1, clock2: Clock) -> bool {
	return clock1.mins == clock2.mins
}
