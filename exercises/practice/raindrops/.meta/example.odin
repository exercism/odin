package raindrops

import "core:strings"

convert :: proc(number: int) -> string {
	b := strings.builder_make_none()
	defer strings.builder_destroy(&b)

	if number % 3 == 0 { strings.write_string(&b, "Pling") }
	if number % 5 == 0 { strings.write_string(&b, "Plang") }
	if number % 7 == 0 { strings.write_string(&b, "Plong") }
	if strings.builder_len(b) == 0 { strings.write_int(&b, number) }
	return strings.to_string(b)
}
