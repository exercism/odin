package protein_translation

import "core:fmt"
import "core:testing"

expect_value_as_string :: proc(
	t: ^testing.T,
	value: []string,
	expected: string,
	loc := #caller_location,
) {

	result := fmt.aprintf("%v", value)
	defer delete(result)

	testing.expect_value(t, result, expected, loc = loc)
}

@(test)
test_empty_rna_sequence_results_in_no_proteins :: proc(t: ^testing.T) {

	result, ok := proteins("")
	defer delete(result)

	expect_value_as_string(t, result, "[]")
	testing.expect_value(t, ok, true)
}

@(test)
test_methionine_rna_sequence :: proc(t: ^testing.T) {

	result, ok := proteins("AUG")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Methionine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_phenylalanine_rna_sequence_1 :: proc(t: ^testing.T) {

	result, ok := proteins("UUU")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Phenylalanine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_phenylalanine_rna_sequence_2 :: proc(t: ^testing.T) {

	result, ok := proteins("UUC")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Phenylalanine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_leucine_rna_sequence_1 :: proc(t: ^testing.T) {

	result, ok := proteins("UUA")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Leucine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_leucine_rna_sequence_2 :: proc(t: ^testing.T) {

	result, ok := proteins("UUG")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Leucine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_serine_rna_sequence_1 :: proc(t: ^testing.T) {

	result, ok := proteins("UCU")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Serine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_serine_rna_sequence_2 :: proc(t: ^testing.T) {

	result, ok := proteins("UCC")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Serine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_serine_rna_sequence_3 :: proc(t: ^testing.T) {

	result, ok := proteins("UCA")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Serine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_serine_rna_sequence_4 :: proc(t: ^testing.T) {

	result, ok := proteins("UCG")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Serine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_tyrosine_rna_sequence_1 :: proc(t: ^testing.T) {

	result, ok := proteins("UAU")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Tyrosine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_tyrosine_rna_sequence_2 :: proc(t: ^testing.T) {

	result, ok := proteins("UAC")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Tyrosine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_cysteine_rna_sequence_1 :: proc(t: ^testing.T) {

	result, ok := proteins("UGU")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Cysteine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_cysteine_rna_sequence_2 :: proc(t: ^testing.T) {

	result, ok := proteins("UGC")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Cysteine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_tryptophan_rna_sequence :: proc(t: ^testing.T) {

	result, ok := proteins("UGG")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Tryptophan\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_stop_codon_rna_sequence_1 :: proc(t: ^testing.T) {

	result, ok := proteins("UAA")
	defer delete(result)

	expect_value_as_string(t, result, "[]")
	testing.expect_value(t, ok, true)
}

@(test)
test_stop_codon_rna_sequence_2 :: proc(t: ^testing.T) {

	result, ok := proteins("UAG")
	defer delete(result)

	expect_value_as_string(t, result, "[]")
	testing.expect_value(t, ok, true)
}

@(test)
test_stop_codon_rna_sequence_3 :: proc(t: ^testing.T) {

	result, ok := proteins("UGA")
	defer delete(result)

	expect_value_as_string(t, result, "[]")
	testing.expect_value(t, ok, true)
}

@(test)
test_sequence_of_two_protein_codons_translates_into_proteins :: proc(t: ^testing.T) {

	result, ok := proteins("UUUUUU")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Phenylalanine\", \"Phenylalanine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_sequence_of_two_different_protein_codons_translates_into_proteins :: proc(t: ^testing.T) {

	result, ok := proteins("UUAUUG")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Leucine\", \"Leucine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_translate_rna_strand_into_correct_protein_list :: proc(t: ^testing.T) {

	result, ok := proteins("AUGUUUUGG")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Methionine\", \"Phenylalanine\", \"Tryptophan\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_translation_stops_if_stop_codon_at_beginning_of_sequence :: proc(t: ^testing.T) {

	result, ok := proteins("UAGUGG")
	defer delete(result)

	expect_value_as_string(t, result, "[]")
	testing.expect_value(t, ok, true)
}

@(test)
test_translation_stops_if_stop_codon_at_end_of_two_codon_sequence :: proc(t: ^testing.T) {

	result, ok := proteins("UGGUAG")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Tryptophan\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_translation_stops_if_stop_codon_at_end_of_three_codon_sequence :: proc(t: ^testing.T) {

	result, ok := proteins("AUGUUUUAA")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Methionine\", \"Phenylalanine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_translation_stops_if_stop_codon_in_middle_of_three_codon_sequence :: proc(t: ^testing.T) {

	result, ok := proteins("UGGUAGUGG")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Tryptophan\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_translation_stops_if_stop_codon_in_middle_of_six_codon_sequence :: proc(t: ^testing.T) {

	result, ok := proteins("UGGUGUUAUUAAUGGUUU")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Tryptophan\", \"Cysteine\", \"Tyrosine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_sequence_of_two_non_stop_codons_does_not_translate_to_a_stop_codon :: proc(t: ^testing.T) {

	result, ok := proteins("AUGAUG")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Methionine\", \"Methionine\"]")
	testing.expect_value(t, ok, true)
}

@(test)
test_unknown_amino_acids_not_part_of_a_codon_cant_translate :: proc(t: ^testing.T) {

	result, ok := proteins("XYZ")
	defer delete(result)

	testing.expect_value(t, ok, false)
}

@(test)
test_incomplete_rna_sequence_cant_translate :: proc(t: ^testing.T) {

	result, ok := proteins("AUGU")
	defer delete(result)

	testing.expect_value(t, ok, false)
}

@(test)
test_incomplete_rna_sequence_can_translate_if_valid_until_a_stop_codon :: proc(t: ^testing.T) {

	result, ok := proteins("UUCUUCUAAUGGU")
	defer delete(result)

	expect_value_as_string(t, result, "[\"Phenylalanine\", \"Phenylalanine\"]")
	testing.expect_value(t, ok, true)
}
