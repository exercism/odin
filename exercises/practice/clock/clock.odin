package clock

import "core:fmt"

// Implement this struct
Clock :: struct {}

create_clock :: proc(hour, minute: int) -> Clock {
	// Implement this procedure.
	return
}

to_string :: proc(clock: Clock) -> string {
	// Implement this procedure.
	return ""
}

add :: proc(clock: ^Clock, minutes: int) {
	// Implement this procedure.
	return
}

subtract :: proc(clock: ^Clock, minutes: int) {
	// Implement this procedure.
	return
}

equals :: proc(clock1, clock2: Clock) -> bool {
	// Implement this procedure.
	return false
}
