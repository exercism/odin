package nucleotide_count

Nucleotide :: enum {
	A,
	C,
	G,
	T,
}

Histogram :: [Nucleotide]int

nucleotide_counts :: proc(dna: string) -> (histogram: Histogram, valid: bool) {
	// Implement this procedure.
	valid = false
	return
}
