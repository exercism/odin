package circular_buffer

Buffer :: struct {
	elements: []int,
	size:     int,
	front:    int,
}

Error :: enum {
	None,
	BufferEmpty,
	BufferFull,
}

new_buffer :: proc(capacity: int) -> Buffer {

	return Buffer{elements = make([]int, capacity)}
}

destroy_buffer :: proc(b: ^Buffer) {

	delete(b.elements)
	b.size = 0
	b.front = 0
}

clear :: proc(b: ^Buffer) {

	b.front = 0
	b.size = 0
}

read :: proc(b: ^Buffer) -> (int, Error) {

	if b.size == 0 {
		return 0, .BufferEmpty
	}
	value := b.elements[b.front]
	b.front = (b.front + 1) % len(b.elements)
	b.size -= 1
	return value, .None
}

write :: proc(b: ^Buffer, value: int) -> Error {

	if b.size == len(b.elements) {
		return .BufferFull
	}
	index := (b.front + b.size) % len(b.elements)
	b.elements[index] = value
	b.size += 1
	return .None
}

overwrite :: proc(b: ^Buffer, value: int) {

	if b.size == len(b.elements) {
		// Buffer is full, remove oldest value and add value.
		b.elements[b.front] = value
		b.front = (b.front + 1) % len(b.elements)
	} else {
		// Buffer is not full, just add one byte.
		index := (b.front + b.size) % len(b.elements)
		b.elements[index] = value
		b.size += 1
	}
}
