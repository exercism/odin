package flatten_array

import "core:slice"
import "core:testing"

@(test)
/// description = empty
test_empty :: proc(t: ^testing.T) {
	array := []Item{}
	result := flatten(array)
	defer delete(result)
	expected := []i32{}
	testing.expect(t, slice.equal(result, expected))
}

@(test)
/// description = no nesting
test_no_nesting :: proc(t: ^testing.T) {
	array := []Item{0, 1, 2}
	result := flatten(array)
	defer delete(result)
	expected := []i32{0, 1, 2}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
/// description = flattens a nested array
test_flattens_a_nested_array :: proc(t: ^testing.T) {
	array := []Item{[]Item{[]Item{}}}
	result := flatten(array)
	defer delete(result)
	expected := []i32{}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
/// description = flattens array with just integers present
test_flattens_array_with_just_integers_present :: proc(t: ^testing.T) {
	array := []Item{1, []Item{2, 3, 4, 5, 6, 7}, 8}
	result := flatten(array)
	defer delete(result)
	expected := []i32{1, 2, 3, 4, 5, 6, 7, 8}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
/// description = 5 level nesting
test_5_level_nesting :: proc(t: ^testing.T) {
	array := []Item{0, 2, []Item{[]Item{2, 3}, 8, 100, 4, []Item{[]Item{[]Item{50}}}}, -2}
	result := flatten(array)
	defer delete(result)
	expected := []i32{0, 2, 2, 3, 8, 100, 4, 50, -2}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
/// description = 6 level nesting
test_6_level_nesting :: proc(t: ^testing.T) {
	array := []Item{1, []Item{2, []Item{[]Item{3}}, []Item{4, []Item{[]Item{5}}}, 6, 7}, 8}
	result := flatten(array)
	defer delete(result)
	expected := []i32{1, 2, 3, 4, 5, 6, 7, 8}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
/// description = null values are omitted from the final result
test_null_values_are_omitted_from_the_final_result :: proc(t: ^testing.T) {
	array := []Item{1, 2, nil}
	result := flatten(array)
	defer delete(result)
	expected := []i32{1, 2}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
/// description = consecutive null values at the front of the array are omitted from the final result
test_consecutive_null_values_at_the_front_of_the_array_are_omitted_from_the_final_result :: proc(
	t: ^testing.T,
) {
	array := []Item{nil, nil, 3}
	result := flatten(array)
	defer delete(result)
	expected := []i32{3}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
/// description = consecutive null values in the middle of the array are omitted from the final result
test_consecutive_null_values_in_the_middle_of_the_array_are_omitted_from_the_final_result :: proc(
	t: ^testing.T,
) {
	array := []Item{1, nil, nil, 4}
	result := flatten(array)
	defer delete(result)
	expected := []i32{1, 4}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)

}

@(test)
/// description = 6 level nested array with null values
test_6_level_nested_array_with_null_values :: proc(t: ^testing.T) {
	array := []Item {
		0,
		2,
		[]Item{[]Item{2, 3}, 8, []Item{[]Item{100}}, nil, []Item{[]Item{nil}}},
		-2,
	}
	result := flatten(array)
	defer delete(result)
	expected := []i32{0, 2, 2, 3, 8, 100, -2}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
/// description = all values in nested array are null
test_all_values_in_nested_array_are_null :: proc(t: ^testing.T) {
	array := []Item{nil, []Item{[]Item{[]Item{nil}}}, nil, nil, []Item{[]Item{nil, nil}, nil}, nil}
	result := flatten(array)
	defer delete(result)
	expected := []i32{}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}
