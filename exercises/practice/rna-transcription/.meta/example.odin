package rna_transcription

to_rna :: proc(dna: string) -> (rna: string, ok: bool) {

	rna_strand := make([]byte, len(dna))

	for x, i in dna {
		switch x {
		case 'G':
			rna_strand[i] = 'C'
		case 'C':
			rna_strand[i] = 'G'
		case 'T':
			rna_strand[i] = 'A'
		case 'A':
			rna_strand[i] = 'U'
		case:
			return
		}
	}
	rna = string(rna_strand)
	ok = true
	return
}
