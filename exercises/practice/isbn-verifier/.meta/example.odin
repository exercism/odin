package isbn_verifier

import "core:text/regex"

is_valid :: proc(isbn: string) -> bool {

	digits, ok := split_isbn(isbn)
	if !ok { return false }
	checksum := 0
	for i := 0; i < 10; i += 1 {
		checksum += digits[i] * (10 - i)
	}
	return checksum % 11 == 0
}

split_isbn :: proc(isbn: string) -> (digits: [10]int, ok: bool) {

	// Odin regexp doesn't allow 10 groups so we have to split in larger
	// groups first (around the optional hyphens) and then splits into
	// digits.

	validator, err := regex.create(`^(\d)[\s-]*(\d\d\d)[\s-]*(\d\d\d\d\d)[\s-]*([\dX])$`)
	ensure(err == nil)
	capture, success := regex.match(validator, isbn)
	defer {
		regex.destroy_regex(validator)
		regex.destroy_capture(capture)
	}
	if !success { return }

	string_to_int(capture.groups[1][:], digits[0:1])
	string_to_int(capture.groups[2][:], digits[1:4])
	string_to_int(capture.groups[3][:], digits[4:9])
	if capture.groups[4] == "X" {
		digits[9] = 10
	} else {
		string_to_int(capture.groups[4][:], digits[9:])
	}
	ok = true
	return
}

string_to_int :: proc(str: string, ints: []int) {

	for char, i in str {
		ints[i] = int(char - '0')
	}
}
