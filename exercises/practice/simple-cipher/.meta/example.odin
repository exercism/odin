package simple_cipher

import "core:math/rand"

decode :: proc(ciphertext, key: string) -> string {

	plaintext := make([]byte, len(ciphertext))
	for i := 0; i < len(ciphertext); i += 1 {
		shift := key[i % len(key)] - 'a'
		plaintext[i] = ciphertext[i] - shift
		// If we go before 'a', start again at 'z'.
		if plaintext[i] < 'a' {
			plaintext[i] += 26
		}
	}
	return string(plaintext)
}

encode :: proc(plaintext, key: string) -> string {

	ciphertext := make([]byte, len(plaintext))
	for i := 0; i < len(plaintext); i += 1 {
		shift := key[i % len(key)] - 'a'
		ciphertext[i] = plaintext[i] + shift
		// If we go past 'z', start again at 'a'.
		if ciphertext[i] > 'z' {
			ciphertext[i] -= 26
		}
	}
	return string(ciphertext)
}

key :: proc() -> string {

	key_bytes := make([]byte, 100)
	for i := 0; i < len(key_bytes); i += 1 {
		key_bytes[i] = u8(rand.int_max(26)) + 'a'
	}
	return string(key_bytes)
}
