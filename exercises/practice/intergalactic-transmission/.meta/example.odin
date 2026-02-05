package intergalactic_transmission

transmit_sequence :: proc(msg: []u8) -> (seq: []u8) {

	if len(msg) == 0 { return nil }

	buf: comm_buffer
	for chunk in msg {
		transmit_chunk(&buf, chunk)
	}
	// There may be some remaining bit in the buffer, flush them.
	if buf.step != 0 {
		transmit_overflow(&buf)
	}
	return buf.data[:]
}

decode_message :: proc(seq: []u8) -> (msg: []u8, okay: bool) {

	if len(seq) == 0 { return nil, true }

	buf: comm_buffer
	for chunk in seq {
		if !has_even_ones(chunk) {
			// We got a chunk with invalid parity, abort!
			delete(buf.data)
			return nil, false
		}
		decode_chunk(&buf, chunk)
	}
	// Because the original message is a set of 8bit words,
	// once we got through all of them, what's left in the overflow register
	// can only be some zeros (the reminder of a last padded chunk) so there is no need
	// to flush the receive buffer.
	return buf.data[:], true
}

comm_buffer :: struct {
	step:     u8,
	overflow: u8,
	data:     [dynamic]u8,
}

// Since we only use 7 bits out of each 8bit word, we get leftovers that
// we store in an overflow register. After the 1st word, the leftover is 1 bit,
// after the 2nd word, the leftover is 2 bits, ..., after each 7th word,
// we end up with enough data in the overflow register to send an extra 8bit
// chunk (including parity bit) herefore the need to flush the buffer every 7
// messages.
//
// For the 1st word, we use the leftmost 7 bits to send and keep the
// 1 rightmost bit in the overflow register.
// For the 2nd word of the message, we will use the 6 leftmost bits
// to build the next tr_chunk and add the 1 bit that was in the overflow
// register to the right of the 6bit block (that bit came first in the
// transmission). We will then be left with 2 bits to store in the
// overflow buffer.
// We repeat the process with, at each step, one less bit of the
// message word going into the chunk and one more bit going into
// the overflow register, until we are left with 7 bits in the
// overflow register, at which point we can emit two chunks
// and go back to the situation we were for the 1st message
// (empty overflow register)
// The tr_chunk_masks and tr_overflow_masks split the current word
// into the rigthmost part (going into the tr_chunk) to be sent
// and the leftmost part (going into the overflow register).
// At each step that split move by 1 bit to the left.
transmit_chunk :: proc(buf: ^comm_buffer, chunk: u8) {

	// Use the leftmost (7 - seq)th bits of chunk and store in position (7-seq)..1.
	tr_chunk := (chunk & tr_chunk_masks[buf.step]) >> buf.step
	// Add seq-th bits of overflow at position 7..(7-seq+1)
	if buf.step > 0 {
		tr_chunk |= (buf.overflow << (8 - buf.step))
	}
	// Store the remaining rightmost bits in the overflow register.
	buf.overflow = chunk & tr_overflow_masks[buf.step]
	package_chunk_for_transmission(buf, tr_chunk)
	buf.step += 1
	// If we have 7 bits in the overflow, we should flush it.
	if buf.step == 7 {
		transmit_overflow(buf)
	}

}

// Every seven steps (when the overflow register has 7 bits)
// and at the end of the message, we need to flush the
// overflow register and send what's in there.
transmit_overflow :: proc(buf: ^comm_buffer) {

	last_chunk := buf.overflow << (8 - buf.step)
	package_chunk_for_transmission(buf, last_chunk)
	// Reset the sequence since we emptied the overflow register.
	buf.step = 0
}

// Add the parity bit and put the chunk in the data buffer for transmission.
package_chunk_for_transmission :: proc(buf: ^comm_buffer, chunk: u8) {

	tr_chunk := chunk
	// Compute and set the parity bit.
	if !has_even_ones(tr_chunk) {
		tr_chunk |= 1
	}
	append(&buf.data, tr_chunk)
}

// Each chunk we receive has 7bits usable. We need to
// collect them in sets of 8bits.
// For the 1st word received, we store the 7 bits in the overflow
// register (in the 7 leftmost bits).
// For the 2nd word, we add the 1 leftmost bit to the
// content of the overflow (to the right of the register),
// queue the now full overflow register and then reuse it
// to store the 6 rightmost remaining bits of the 2nd word.
// For each successive word, we keep doing this but with
// one more bit going to complete the previous overflow
// and one less bit going to the new overflow, until there is
// no more bits to go in the new overflow. At which point
// we are back to the same situation as for the first word.
decode_chunk :: proc(buf: ^comm_buffer, chunk: u8) {

	// Remove the parity bit
	rc_chunk := (chunk & 0xFE) >> 1
	if buf.step == 0 {
		// Store the chunk in the top of the overflow register.
		buf.overflow = rc_chunk << 1
	} else {
		// Store the rightmost bits at the bottom of the overflow register.
		buf.overflow |= ((rc_chunk & rc_chunk_masks[buf.step - 1]) >> (7 - buf.step))
		// We have a full overflow register, output it.
		append(&buf.data, buf.overflow)
		// Store the leftmost remaining bits at the top of the overflow register.
		buf.overflow = (rc_chunk & rc_overflow_masks[buf.step - 1]) << (buf.step + 1)
	}
	buf.step = (buf.step + 1) % 8
}

// Check if the word has an even number of bits set to 1.
has_even_ones :: proc(n: u8) -> bool {

	ones := 0
	num := n
	for _ in 0 ..= 7 {
		if num & 1 == 1 {
			ones += 1
		}
		num = num >> 1
	}
	return ones & 1 == 0
}

// Since these masks splits 8 bits into two parts: tr_chunk_masks[i] + tr_overflow_masks[i] = 0xFF
tr_chunk_masks := [?]u8{0xFE, 0xFC, 0xF8, 0xF0, 0xE0, 0xC0, 0x80}
tr_overflow_masks := [?]u8{0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F, 0x7F}

// Since these masks splits 7 bits into two parts: rc_chunk_masks[i] + rc_overflow_masks[i] = 0x7F
rc_chunk_masks := [?]u8{0x40, 0x60, 0x70, 0x78, 0x7C, 0x7E, 0x7F}
rc_overflow_masks := [?]u8{0x3F, 0x1F, 0x0F, 0x07, 0x03, 0x01, 0x00}
