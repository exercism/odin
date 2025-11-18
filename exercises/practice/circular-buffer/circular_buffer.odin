package circular_buffer

// Complete the Buffer data structure.
Buffer :: struct {}

// Populate the Error enum to match output of test cases.
Error :: enum {
	None,
	BufferEmpty,
	BufferFull,
}

new_buffer :: proc(capacity: int) -> Buffer {
	#panic("implement this procedure")
}

destroy_buffer :: proc(b: ^Buffer) {
	#panic("implement this procedure")
}

clear :: proc(b: ^Buffer) {
	#panic("implement this procedure")
}

read :: proc(b: ^Buffer) -> (int, Error) {
	#panic("implement this procedure")
}

write :: proc(b: ^Buffer, value: int) -> Error {
	#panic("implement this procedure")
}


overwrite :: proc(b: ^Buffer, value: int) {
	#panic("implement this procedure")
}
