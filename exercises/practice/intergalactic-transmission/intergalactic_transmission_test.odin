package intergalactic_transmission

import "core:fmt"
import "core:strings"
import "core:testing"

@(test)
/// description = calculate transmit sequences -> empty message
test_calculate_transmit_sequences___empty_message :: proc(t: ^testing.T) {

	input := [?]u8{}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = calculate transmit sequences -> 0x00 is transmitted as 0x0000
test_calculate_transmit_sequences___0x00_is_transmitted_as_0x0000 :: proc(t: ^testing.T) {

	input := [?]u8{0x00}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x00, 0x00]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = calculate transmit sequences -> 0x02 is transmitted as 0x0300
test_calculate_transmit_sequences___0x02_is_transmitted_as_0x0300 :: proc(t: ^testing.T) {

	input := [?]u8{0x02}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x03, 0x00]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = calculate transmit sequences -> 0x06 is transmitted as 0x0600
test_calculate_transmit_sequences___0x06_is_transmitted_as_0x0600 :: proc(t: ^testing.T) {

	input := [?]u8{0x06}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x06, 0x00]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = calculate transmit sequences -> 0x05 is transmitted as 0x0581
test_calculate_transmit_sequences___0x05_is_transmitted_as_0x0581 :: proc(t: ^testing.T) {

	input := [?]u8{0x05}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x05, 0x81]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = calculate transmit sequences -> 0x29 is transmitted as 0x2881
test_calculate_transmit_sequences___0x29_is_transmitted_as_0x2881 :: proc(t: ^testing.T) {

	input := [?]u8{0x29}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x28, 0x81]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = calculate transmit sequences -> 0xc001c0de is transmitted as 0xc000711be1
test_calculate_transmit_sequences___0xc001c0de_is_transmitted_as_0xc000711be1 :: proc(
	t: ^testing.T,
) {

	input := [?]u8{0xc0, 0x01, 0xc0, 0xde}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0xC0, 0x00, 0x71, 0x1B, 0xE1]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = calculate transmit sequences -> six byte message
test_calculate_transmit_sequences___six_byte_message :: proc(t: ^testing.T) {

	input := [?]u8{0x47, 0x72, 0x65, 0x61, 0x74, 0x21}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x47, 0xB8, 0x99, 0xAC, 0x17, 0xA0, 0x84]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = calculate transmit sequences -> seven byte message
test_calculate_transmit_sequences___seven_byte_message :: proc(t: ^testing.T) {

	input := [?]u8{0x47, 0x72, 0x65, 0x61, 0x74, 0x31, 0x21}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x47, 0xB8, 0x99, 0xAC, 0x17, 0xA0, 0xC5, 0x42]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = calculate transmit sequences -> eight byte message
test_calculate_transmit_sequences___eight_byte_message :: proc(t: ^testing.T) {

	input := [?]u8{0xc0, 0x01, 0x13, 0x37, 0xc0, 0xde, 0x21, 0x21}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0xC0, 0x00, 0x44, 0x66, 0x7D, 0x06, 0x78, 0x42, 0x21, 0x81]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = calculate transmit sequences -> twenty byte message
test_calculate_transmit_sequences___twenty_byte_message :: proc(t: ^testing.T) {

	input := [?]u8 {
		0x45,
		0x78,
		0x65,
		0x72,
		0x63,
		0x69,
		0x73,
		0x6d,
		0x20,
		0x69,
		0x73,
		0x20,
		0x61,
		0x77,
		0x65,
		0x73,
		0x6f,
		0x6d,
		0x65,
		0x21,
	}
	output := transmit_sequence(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x44, 0xBD, 0x18, 0xAF, 0x27, 0x1B, 0xA5, 0xE7, 0x6C, 0x90, 0x1B, 0x2E, 0x33, 0x03, 0x84, 0xEE, 0x65, 0xB8, 0xDB, 0xED, 0xD7, 0x28, 0x84]"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> empty message
test_decode_received_messages___empty_message :: proc(t: ^testing.T) {

	input := [?]u8{}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> zero message
test_decode_received_messages___zero_message :: proc(t: ^testing.T) {

	input := [?]u8{0x00, 0x00}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x00]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> 0x0300 is decoded to 0x02
test_decode_received_messages___0x0300_is_decoded_to_0x02 :: proc(t: ^testing.T) {

	input := [?]u8{0x03, 0x00}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x02]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> 0x0581 is decoded to 0x05
test_decode_received_messages___0x0581_is_decoded_to_0x05 :: proc(t: ^testing.T) {

	input := [?]u8{0x05, 0x81}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x05]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> 0x2881 is decoded to 0x29
test_decode_received_messages___0x2881_is_decoded_to_0x29 :: proc(t: ^testing.T) {

	input := [?]u8{0x28, 0x81}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x29]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> first byte has wrong parity
test_decode_received_messages___first_byte_has_wrong_parity :: proc(t: ^testing.T) {

	input := [?]u8{0x07, 0x00}
	output, okay := decode_message(input[:])
	defer delete(output)
	testing.expectf(t, !okay, "Expected the message to be invalid but got okay = true")
}

@(test)
/// description = decode received messages -> second byte has wrong parity
test_decode_received_messages___second_byte_has_wrong_parity :: proc(t: ^testing.T) {

	input := [?]u8{0x03, 0x68}
	output, okay := decode_message(input[:])
	defer delete(output)
	testing.expectf(t, !okay, "Expected the message to be invalid but got okay = true")
}

@(test)
/// description = decode received messages -> 0xcf4b00 is decoded to 0xce94
test_decode_received_messages___0xcf4b00_is_decoded_to_0xce94 :: proc(t: ^testing.T) {

	input := [?]u8{0xcf, 0x4b, 0x00}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0xCE, 0x94]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> 0xe2566500 is decoded to 0xe2ad90
test_decode_received_messages___0xe2566500_is_decoded_to_0xe2ad90 :: proc(t: ^testing.T) {

	input := [?]u8{0xe2, 0x56, 0x65, 0x00}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0xE2, 0xAD, 0x90]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> six byte message
test_decode_received_messages___six_byte_message :: proc(t: ^testing.T) {

	input := [?]u8{0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0x84}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x47, 0x72, 0x65, 0x61, 0x74, 0x21]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> seven byte message
test_decode_received_messages___seven_byte_message :: proc(t: ^testing.T) {

	input := [?]u8{0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0xc5, 0x42}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x47, 0x72, 0x65, 0x61, 0x74, 0x31, 0x21]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> last byte has wrong parity
test_decode_received_messages___last_byte_has_wrong_parity :: proc(t: ^testing.T) {

	input := [?]u8{0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0xc5, 0x43}
	output, okay := decode_message(input[:])
	defer delete(output)
	testing.expectf(t, !okay, "Expected the message to be invalid but got okay = true")
}

@(test)
/// description = decode received messages -> eight byte message
test_decode_received_messages___eight_byte_message :: proc(t: ^testing.T) {

	input := [?]u8{0xc0, 0x00, 0x44, 0x66, 0x7d, 0x06, 0x78, 0x42, 0x21, 0x81}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0xC0, 0x01, 0x13, 0x37, 0xC0, 0xDE, 0x21, 0x21]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> twenty byte message
test_decode_received_messages___twenty_byte_message :: proc(t: ^testing.T) {

	input := [?]u8 {
		0x44,
		0xbd,
		0x18,
		0xaf,
		0x27,
		0x1b,
		0xa5,
		0xe7,
		0x6c,
		0x90,
		0x1b,
		0x2e,
		0x33,
		0x03,
		0x84,
		0xee,
		0x65,
		0xb8,
		0xdb,
		0xed,
		0xd7,
		0x28,
		0x84,
	}
	output, okay := decode_message(input[:])
	result := to_hex_sequence(output)
	defer {
		delete(output)
		delete(result)
	}
	expected := "[0x45, 0x78, 0x65, 0x72, 0x63, 0x69, 0x73, 0x6D, 0x20, 0x69, 0x73, 0x20, 0x61, 0x77, 0x65, 0x73, 0x6F, 0x6D, 0x65, 0x21]"
	testing.expectf(t, okay, "Expected the message to be valid but got okay = false")
	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode received messages -> wrong parity on 16th byte
test_decode_received_messages___wrong_parity_on_16th_byte :: proc(t: ^testing.T) {

	input := [?]u8 {
		0x44,
		0xbd,
		0x18,
		0xaf,
		0x27,
		0x1b,
		0xa5,
		0xe7,
		0x6c,
		0x90,
		0x1b,
		0x2e,
		0x33,
		0x03,
		0x84,
		0xef,
		0x65,
		0xb8,
		0xdb,
		0xed,
		0xd7,
		0x28,
		0x84,
	}
	output, okay := decode_message(input[:])
	defer delete(output)
	testing.expectf(t, !okay, "Expected the message to be invalid but got okay = true")
}

// Helper function to comvert a slice of u8 to its hexadecimal representation
// Note: we don't use `expect_slices()` because the resulting values would be displayed in
// decimal, not hexadecimal as we need to be compatible with the content of the tests.
to_hex_sequence :: proc(sequence: []u8) -> string {

	buf := strings.builder_make()
	strings.write_rune(&buf, '[')
	for value, i in sequence {
		if i > 0 {
			strings.write_string(&buf, ", ")
		}
		hex_value := fmt.aprintf("%#02X", value)
		defer delete(hex_value)
		strings.write_string(&buf, hex_value)
	}
	strings.write_rune(&buf, ']')
	return strings.to_string(buf)
}
