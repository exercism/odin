package rna_transcription

import "core:strings"

to_rna :: proc(dna: string) -> (rna: string, ok: bool) {
	b := strings.builder_make_len_cap(0, len(dna))
	defer strings.builder_destroy(&b)

	for x in dna {
		switch x {
		case 'G':
			strings.write_byte(&b, 'C')
		case 'C':
			strings.write_byte(&b, 'G')
		case 'T':
			strings.write_byte(&b, 'A')
		case 'A':
			strings.write_byte(&b, 'U')
		case:
			return "", false
		}
	}
	rna = strings.to_string(b)
	return rna, true
}
