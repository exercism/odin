package roman_numerals

import "core:strings"

to_roman_numeral :: proc(decimal: int) -> string {

	buffer := strings.builder_make()
	build_roman_number(&buffer, decimal)
	// the returned string shares its underlying array with the buffer.
	// It is up to the caller to release the buffer/string memory.
	return strings.to_string(buffer)
}

build_roman_number :: proc(b: ^strings.Builder, decimal: int) {

	switch {
	case decimal >= 1000:
		strings.write_rune(b, 'M')
		build_roman_number(b, decimal - 1000)
	case decimal >= 900:
		strings.write_string(b, "CM")
		build_roman_number(b, decimal - 900)
	case decimal >= 500:
		strings.write_rune(b, 'D')
		build_roman_number(b, decimal - 500)
	case decimal >= 400:
		strings.write_string(b, "CD")
		build_roman_number(b, decimal - 400)
	case decimal >= 100:
		strings.write_rune(b, 'C')
		build_roman_number(b, decimal - 100)
	case decimal >= 90:
		strings.write_string(b, "XC")
		build_roman_number(b, decimal - 90)
	case decimal >= 50:
		strings.write_rune(b, 'L')
		build_roman_number(b, decimal - 50)
	case decimal >= 40:
		strings.write_string(b, "XL")
		build_roman_number(b, decimal - 40)
	case decimal >= 10:
		strings.write_rune(b, 'X')
		build_roman_number(b, decimal - 10)
	case decimal >= 9:
		strings.write_string(b, "IX")
		build_roman_number(b, decimal - 9)
	case decimal >= 5:
		strings.write_rune(b, 'V')
		build_roman_number(b, decimal - 5)
	case decimal >= 4:
		strings.write_string(b, "IV")
		build_roman_number(b, decimal - 4)
	case decimal >= 1:
		strings.write_rune(b, 'I')
		build_roman_number(b, decimal - 1)
	case:
		return
	}
}
