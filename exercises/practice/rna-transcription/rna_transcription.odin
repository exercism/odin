package rna_transcription

import "core:strings"

to_rna :: proc(dna: string) -> (rna: string, ok: bool) {
	// Allocate memory for a new string builder. Its initial length is zero and its capacity is the
	// length of the input DNA string.
	b := strings.builder_make_len_cap(0, len(dna))

	// Remember to free the memory allocated to the builder at the end of this procedure's scope.
	defer strings.builder_destroy(&b)

	// Next, use the string builder to generate the RNA string.
	#panic("Please complete the `to_rna` procedure.")
}
