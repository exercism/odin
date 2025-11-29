package nucleotide_count

Nucleotide :: enum {
	A,
	C,
	G,
	T,
}

Histogram :: [Nucleotide]int

nucleotide_counts :: proc(dna: string) -> (histogram: Histogram, valid: bool) {

	for letter in dna {
		nucleotide, valid_letter := letter_to_nucleotide(letter)
		if !valid_letter {
			valid = false
			return
		}
		histogram[nucleotide] += 1
	}
	valid = true
	return
}

letter_to_nucleotide :: proc(l: rune) -> (Nucleotide, bool) {

	switch l {
	case 'A':
		return .A, true
	case 'C':
		return .C, true
	case 'G':
		return .G, true
	case 'T':
		return .T, true
	}
	return .A, false
}
