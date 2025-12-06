package atbash_cipher

import "core:testing"

@(test)
/// description = encode -> encode yes
test_encode__encode_yes :: proc(t: ^testing.T) {

	input := "yes"
	result := encode(input)
	defer delete(result)
	expected := "bvh"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = encode -> encode no
test_encode__encode_no :: proc(t: ^testing.T) {

	input := "no"
	result := encode(input)
	defer delete(result)
	expected := "ml"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = encode -> encode OMG
test_encode__encode_omg :: proc(t: ^testing.T) {

	input := "OMG"
	result := encode(input)
	defer delete(result)
	expected := "lnt"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = encode -> encode spaces
test_encode__encode_spaces :: proc(t: ^testing.T) {

	input := "O M G"
	result := encode(input)
	defer delete(result)
	expected := "lnt"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = encode -> encode mindblowingly
test_encode__encode_mindblowingly :: proc(t: ^testing.T) {

	input := "mindblowingly"
	result := encode(input)
	defer delete(result)
	expected := "nrmwy oldrm tob"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = encode -> encode numbers
test_encode__encode_numbers :: proc(t: ^testing.T) {

	input := "Testing,1 2 3, testing."
	result := encode(input)
	defer delete(result)
	expected := "gvhgr mt123 gvhgr mt"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = encode -> encode deep thought
test_encode__encode_deep_thought :: proc(t: ^testing.T) {

	input := "Truth is fiction."
	result := encode(input)
	defer delete(result)
	expected := "gifgs rhurx grlm"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = encode -> encode all the letters
test_encode__encode_all_the_letters :: proc(t: ^testing.T) {

	input := "The quick brown fox jumps over the lazy dog."
	result := encode(input)
	defer delete(result)
	expected := "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode -> decode exercism
test_decode__decode_exercism :: proc(t: ^testing.T) {

	input := "vcvix rhn"
	result := decode(input)
	defer delete(result)
	expected := "exercism"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode -> decode a sentence
test_decode__decode_a_sentence :: proc(t: ^testing.T) {

	input := "zmlyh gzxov rhlug vmzhg vkkrm thglm v"
	result := decode(input)
	defer delete(result)
	expected := "anobstacleisoftenasteppingstone"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode -> decode numbers
test_decode__decode_numbers :: proc(t: ^testing.T) {

	input := "gvhgr mt123 gvhgr mt"
	result := decode(input)
	defer delete(result)
	expected := "testing123testing"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode -> decode all the letters
test_decode__decode_all_the_letters :: proc(t: ^testing.T) {

	input := "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
	result := decode(input)
	defer delete(result)
	expected := "thequickbrownfoxjumpsoverthelazydog"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode -> decode with too many spaces
test_decode__decode_with_too_many_spaces :: proc(t: ^testing.T) {

	input := "vc vix    r hn"
	result := decode(input)
	defer delete(result)
	expected := "exercism"

	testing.expect_value(t, result, expected)
}

@(test)
/// description = decode -> decode with no spaces
test_decode__decode_with_no_spaces :: proc(t: ^testing.T) {

	input := "zmlyhgzxovrhlugvmzhgvkkrmthglmv"
	result := decode(input)
	defer delete(result)
	expected := "anobstacleisoftenasteppingstone"

	testing.expect_value(t, result, expected)
}
