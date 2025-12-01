package protein_translation

// Use a constant to avoid typo errors when checking
// for STOP codon.

STOP :: "STOP"

// proteins returns the list of aminoacid associated with the rna_strand.
// The second parameter indicates if the translation was successful.
proteins :: proc(rna_strand: string) -> ([]string, bool) {

	proteins := make([dynamic]string)
	for i := 0; i < len(rna_strand); i += 3 {
		// We have an incomplete sequence.
		if i + 3 > len(rna_strand) {
			// Need to clean up since we don't pass the proteins
			// array back to the caller.
			delete(proteins)
			return nil, false
		}
		codon := rna_strand[i:i + 3]
		aminoacid := codon_to_aminoacid(codon)
		if aminoacid == "" {
			// Need to clean up since we don't pass the proteins
			// array back to the caller.
			delete(proteins)
			return nil, false
		} else if aminoacid == STOP {
			// We stop the translation when we encounter a STOP codon.
			break
		}
		append(&proteins, aminoacid)
	}
	return proteins[:], true
}

// codon_to_aminoacid maps the codons to the amino acids they represent.
// When the codon is invalid, it returns an empty string (no amino acid).
//
// In a GC language, we would have made this a map because it's more
// declarative but in Odin we have to worry about reclaiming memory
// and this map would have been a package level map requiring an @(init)
// and @(fini) procedure and even that is a problem since these procedures
// are supposed to be "contextless".
codon_to_aminoacid :: proc(codon: string) -> string {
	switch codon {
	case "AUG":
		return "Methionine"
	case "UUU", "UUC":
		return "Phenylalanine"
	case "UUA", "UUG":
		return "Leucine"
	case "UCU", "UCC", "UCA", "UCG":
		return "Serine"
	case "UAU", "UAC":
		return "Tyrosine"
	case "UGU", "UGC":
		return "Cysteine"
	case "UGG":
		return "Tryptophan"
	case "UAA", "UAG", "UGA":
		return STOP
	}
	return ""
}
