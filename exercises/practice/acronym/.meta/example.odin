package acronym

import "core:strings"
import "core:text/regex"

abbreviate :: proc(phrase: string) -> string {

	pattern :: `[^ _-]+`
	// Since we know the (static) regex pattern is correct and
	// there is no way to report an error in the procedure, just ignore
	// the return error value.
	iter, _ := regex.create_iterator(phrase, pattern)
	defer regex.destroy_iterator(iter)

	buffer := strings.builder_make()
	defer strings.builder_destroy(&buffer)
	for {
		capture, _, ok := regex.match_iterator(&iter)
		if !ok { break }
		first_letter := capture.groups[0][0]
		strings.write_byte(&buffer, first_letter)
	}

	acronym := strings.to_upper(strings.to_string(buffer))
	return acronym

}
