package simple_cipher

import "core:strings"
import "core:testing"

@(test)
/// description = Random key cipher -> Can encode
test_random_key_cipher___can_encode :: proc(t: ^testing.T) {

	plaintext := "aaaaaaaaaa"
	random_key := key()
	result := encode(plaintext, random_key)
	expected, _ := strings.substring(random_key, 0, len(plaintext))
	defer {
		delete(random_key)
		delete(result)
	}

	testing.expectf(
		t,
		len(random_key) >= 100,
		"key() returns key of less than 100 characters (%d)",
		len(random_key),
	)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Random key cipher -> Can decode
test_random_key_cipher___can_decode :: proc(t: ^testing.T) {

	random_key := key()
	expected := "aaaaaaaaaa"
	ciphertext, _ := strings.substring(random_key, 0, len(expected))
	result := decode(ciphertext, random_key)
	defer {
		delete(random_key)
		delete(result)
	}

	testing.expectf(
		t,
		len(random_key) >= 100,
		"key() returns key of less than 100 characters (%d)",
		len(random_key),
	)
	testing.expect_value(t, result, expected)
}

@(test)
/// description = Random key cipher -> Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method
test_random_key_cipher___is_reversible_ie_if_you_apply_decode_in_a_encoded_result_you_must_see_the_same_plaintext_encode_parameter_as_a_result_of_the_decode_method :: proc(
	t: ^testing.T,
) {

	random_key := key()
	plaintext := "abcdefghij"
	ciphertext := encode(plaintext, random_key)
	result := decode(ciphertext, random_key)
	defer {
		delete(random_key)
		delete(ciphertext)
		delete(result)
	}

	testing.expect_value(t, result, plaintext)
}

@(test)
/// description = Random key cipher -> Key is made only of lowercase letters
test_random_key_cipher___key_is_made_only_of_lowercase_letters :: proc(t: ^testing.T) {

	random_key := key()
	expected := strings.to_lower(random_key)
	defer {
		delete(random_key)
		delete(expected)
	}

	testing.expect_value(t, random_key, expected)
}

@(test)
/// description = Substitution cipher -> Can encode
test_substitution_cipher___can_encode :: proc(t: ^testing.T) {

	key := "abcdefghij"
	plaintext := "aaaaaaaaaa"
	result := encode(plaintext, key)
	expected := "abcdefghij"
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Substitution cipher -> Can decode
test_substitution_cipher___can_decode :: proc(t: ^testing.T) {

	key := "abcdefghij"
	ciphertext := "abcdefghij"
	result := decode(ciphertext, key)
	expected := "aaaaaaaaaa"
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Substitution cipher -> Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method
test_substitution_cipher___is_reversible_ie_if_you_apply_decode_in_a_encoded_result_you_must_see_the_same_plaintext_encode_parameter_as_a_result_of_the_decode_method :: proc(
	t: ^testing.T,
) {

	key := "abcdefghij"
	plaintext := "abcdefghij"
	ciphertext := encode(plaintext, key)
	result := decode(ciphertext, key)
	defer {
		delete(ciphertext)
		delete(result)
	}

	testing.expect_value(t, result, plaintext)
}

@(test)
/// description = Substitution cipher -> Can double shift encode
test_substitution_cipher___can_double_shift_encode :: proc(t: ^testing.T) {

	key := "iamapandabear"
	plaintext := "iamapandabear"
	result := encode(plaintext, key)
	expected := "qayaeaagaciai"
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Substitution cipher -> Can wrap on encode
test_substitution_cipher___can_wrap_on_encode :: proc(t: ^testing.T) {

	key := "abcdefghij"
	plaintext := "zzzzzzzzzz"
	result := encode(plaintext, key)
	expected := "zabcdefghi"
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Substitution cipher -> Can wrap on decode
test_substitution_cipher___can_wrap_on_decode :: proc(t: ^testing.T) {

	key := "abcdefghij"
	ciphertext := "zabcdefghi"
	result := decode(ciphertext, key)
	expected := "zzzzzzzzzz"
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Substitution cipher -> Can encode messages longer than the key
test_substitution_cipher___can_encode_messages_longer_than_the_key :: proc(t: ^testing.T) {

	key := "abc"
	plaintext := "iamapandabear"
	result := encode(plaintext, key)
	expected := "iboaqcnecbfcr"
	defer delete(result)

	testing.expect_value(t, result, expected)
}

@(test)
/// description = Substitution cipher -> Can decode messages longer than the key
test_substitution_cipher___can_decode_messages_longer_than_the_key :: proc(t: ^testing.T) {

	key := "abc"
	ciphertext := "iboaqcnecbfcr"
	result := decode(ciphertext, key)
	expected := "iamapandabear"
	defer delete(result)

	testing.expect_value(t, result, expected)
}
