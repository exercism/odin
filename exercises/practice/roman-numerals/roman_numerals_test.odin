package roman_numerals

import "core:testing"

@(test)
test_1_is_i :: proc(t: ^testing.T) {

	expected := "I"
	decimal := 1
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_2_is_ii :: proc(t: ^testing.T) {

	expected := "II"
	decimal := 2
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_3_is_iii :: proc(t: ^testing.T) {
	expected := "III"
	decimal := 3
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_4_is_iv :: proc(t: ^testing.T) {
	expected := "IV"
	decimal := 4
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_5_is_v :: proc(t: ^testing.T) {
	expected := "V"
	decimal := 5
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_6_is_vi :: proc(t: ^testing.T) {
	expected := "VI"
	decimal := 6
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_9_is_ix :: proc(t: ^testing.T) {
	expected := "IX"
	decimal := 9
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_16_is_xvi :: proc(t: ^testing.T) {
	expected := "XVI"
	decimal := 16
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_27_is_xxvii :: proc(t: ^testing.T) {
	expected := "XXVII"
	decimal := 27
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_48_is_xlviii :: proc(t: ^testing.T) {
	expected := "XLVIII"
	decimal := 48
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_49_is_xlix :: proc(t: ^testing.T) {
	expected := "XLIX"
	decimal := 49
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_59_is_lix :: proc(t: ^testing.T) {
	expected := "LIX"
	decimal := 59
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_66_is_lxvi :: proc(t: ^testing.T) {
	expected := "LXVI"
	decimal := 66
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_93_is_xciii :: proc(t: ^testing.T) {
	expected := "XCIII"
	decimal := 93
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_141_is_cxli :: proc(t: ^testing.T) {
	expected := "CXLI"
	decimal := 141
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_163_is_clxiii :: proc(t: ^testing.T) {
	expected := "CLXIII"
	decimal := 163
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_166_is_clxvi :: proc(t: ^testing.T) {
	expected := "CLXVI"
	decimal := 166
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_402_is_cdii :: proc(t: ^testing.T) {
	expected := "CDII"
	decimal := 402
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_575_is_dlxxv :: proc(t: ^testing.T) {
	expected := "DLXXV"
	decimal := 575
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_666_is_dclxvi :: proc(t: ^testing.T) {
	expected := "DCLXVI"
	decimal := 666
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_911_is_cmxi :: proc(t: ^testing.T) {
	expected := "CMXI"
	decimal := 911
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_1024_is_mxxiv :: proc(t: ^testing.T) {
	expected := "MXXIV"
	decimal := 1024
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_1666_is_mdclxvi :: proc(t: ^testing.T) {
	expected := "MDCLXVI"
	decimal := 1666
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_3000_is_mmm :: proc(t: ^testing.T) {
	expected := "MMM"
	decimal := 3000
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_3001_is_mmmi :: proc(t: ^testing.T) {
	expected := "MMMI"
	decimal := 3001
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_3888_is_mmmdccclxxxviii :: proc(t: ^testing.T) {
	expected := "MMMDCCCLXXXVIII"
	decimal := 3888
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
test_3999_is_mmmcmxcix :: proc(t: ^testing.T) {
	expected := "MMMCMXCIX"
	decimal := 3999
	result := to_roman_numeral(decimal)
	defer delete(result)

	testing.expect_value(t, result, expected)
}
