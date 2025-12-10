package bottle_song

import "core:fmt"
import "core:testing"

expect_slices_match :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {

	result := fmt.aprintf("%v", actual)
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str, loc = loc)
}

delete_string_slice :: proc(slice: []string) {

	for elem in slice {
		delete(elem)
	}
	delete(slice)
}

@(test)
/// description = verse -> single verse -> first generic verse
test_verse___single_verse___first_generic_verse :: proc(t: ^testing.T) {

	result := recite(10, 1)
	defer delete_string_slice(result)

	expected := [?]string {
		"Ten green bottles hanging on the wall,",
		"Ten green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be nine green bottles hanging on the wall.",
	}

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = verse -> single verse -> last generic verse
test_verse___single_verse___last_generic_verse :: proc(t: ^testing.T) {

	result := recite(3, 1)
	defer delete_string_slice(result)

	expected := [?]string {
		"Three green bottles hanging on the wall,",
		"Three green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be two green bottles hanging on the wall.",
	}

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = verse -> single verse -> verse with 2 bottles
test_verse___single_verse___verse_with_2_bottles :: proc(t: ^testing.T) {

	result := recite(2, 1)
	defer delete_string_slice(result)
	expected := [?]string {
		"Two green bottles hanging on the wall,",
		"Two green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be one green bottle hanging on the wall.",
	}

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = verse -> single verse -> verse with 1 bottle
test_verse___single_verse___verse_with_1_bottle :: proc(t: ^testing.T) {

	result := recite(1, 1)
	defer delete_string_slice(result)
	expected := [?]string {
		"One green bottle hanging on the wall,",
		"One green bottle hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be no green bottles hanging on the wall.",
	}

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = lyrics -> multiple verses -> first two verses
test_lyrics___multiple_verses___first_two_verses :: proc(t: ^testing.T) {

	result := recite(10, 2)
	defer delete_string_slice(result)
	expected := [?]string {
		"Ten green bottles hanging on the wall,",
		"Ten green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be nine green bottles hanging on the wall.",
		"",
		"Nine green bottles hanging on the wall,",
		"Nine green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be eight green bottles hanging on the wall.",
	}

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = lyrics -> multiple verses -> last three verses
test_lyrics___multiple_verses___last_three_verses :: proc(t: ^testing.T) {

	result := recite(3, 3)
	defer delete_string_slice(result)
	expected := [?]string {
		"Three green bottles hanging on the wall,",
		"Three green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be two green bottles hanging on the wall.",
		"",
		"Two green bottles hanging on the wall,",
		"Two green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be one green bottle hanging on the wall.",
		"",
		"One green bottle hanging on the wall,",
		"One green bottle hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be no green bottles hanging on the wall.",
	}

	expect_slices_match(t, result, expected[:])
}

@(test)
/// description = lyrics -> multiple verses -> all verses
test_lyrics___multiple_verses___all_verses :: proc(t: ^testing.T) {

	result := recite(10, 10)
	defer delete_string_slice(result)
	expected := [?]string {
		"Ten green bottles hanging on the wall,",
		"Ten green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be nine green bottles hanging on the wall.",
		"",
		"Nine green bottles hanging on the wall,",
		"Nine green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be eight green bottles hanging on the wall.",
		"",
		"Eight green bottles hanging on the wall,",
		"Eight green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be seven green bottles hanging on the wall.",
		"",
		"Seven green bottles hanging on the wall,",
		"Seven green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be six green bottles hanging on the wall.",
		"",
		"Six green bottles hanging on the wall,",
		"Six green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be five green bottles hanging on the wall.",
		"",
		"Five green bottles hanging on the wall,",
		"Five green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be four green bottles hanging on the wall.",
		"",
		"Four green bottles hanging on the wall,",
		"Four green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be three green bottles hanging on the wall.",
		"",
		"Three green bottles hanging on the wall,",
		"Three green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be two green bottles hanging on the wall.",
		"",
		"Two green bottles hanging on the wall,",
		"Two green bottles hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be one green bottle hanging on the wall.",
		"",
		"One green bottle hanging on the wall,",
		"One green bottle hanging on the wall,",
		"And if one green bottle should accidentally fall,",
		"There'll be no green bottles hanging on the wall.",
	}

	expect_slices_match(t, result, expected[:])
}
