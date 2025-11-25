package circular_buffer

// Complete the Buffer data structure.
Buffer :: struct {}

Error :: enum {
	None,
	BufferEmpty,
	BufferFull,
	Unimplemented,
}

new_buffer :: proc(capacity: int) -> Buffer {
	// implement this procedure.
	return Buffer{}
}

destroy_buffer :: proc(b: ^Buffer) {
	// implement this procedure.
}

clear :: proc(b: ^Buffer) {
	// implement this procedure.
}

read :: proc(b: ^Buffer) -> (int, Error) {
	// implement this procedure.
	return 0, .Unimplemented
}

write :: proc(b: ^Buffer, value: int) -> Error {
	// implement this procedure.
	return .Unimplemented
}

overwrite :: proc(b: ^Buffer, value: int) {
	// implement this procedure.
}
