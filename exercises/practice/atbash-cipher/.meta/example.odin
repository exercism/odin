package atbash_cipher

encode :: proc(sentence: string) -> string {

	// When encoding, insert a space every block of 5 letters.
	return encode_by_block(sentence, 5)
}

decode :: proc(sentence: string) -> string {

	// Encoding / Decoding is symmetric.
	// But decoding doesn't insert spaces after a block of letters.
	return encode_by_block(sentence, 0)
}

encode_by_block :: proc(sentence: string, block_size: int) -> string {

	// We are assuming the sentence is in ASCII (0-255).
	// Need to insert a space after each group of `block_size` letters.
	coded_sentence := make([dynamic]byte, 0, len(sentence))
	count := 0
	for i in 0 ..< len(sentence) {
		coded_letter, ok := encode_letter(sentence[i])
		if ok {
			if count != 0 && count == block_size {
				append(&coded_sentence, ' ')
				count = 0
			}
			append(&coded_sentence, coded_letter)
			count += 1
		}
	}
	return string(coded_sentence[:])
}

encode_letter :: proc(l: byte) -> (byte, bool) {

	switch {
	case l >= '0' && l <= '9':
		return l, true
	case l >= 'a' && l <= 'z':
		return ('a' + 'z' - l), true
	case l >= 'A' && l <= 'Z':
		return ('a' + 'Z' - l), true
	case:
		return 0, false
	}
}
