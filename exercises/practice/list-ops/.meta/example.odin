package list_ops

// All procedures use prefix `ls_` to avoid conflict
// with Odin built-in `append()` and `map`.

// Returns a new list with 'other' appended to 'l'.
ls_append :: proc(l: []$T, other: []T) -> []T {

	new_list := make([dynamic]T, 0, len(l) + len(other))
	append(&new_list, ..l)
	append(&new_list, ..other)
	return new_list[:]
}

// Creates a new list by concatenating all the argument lists.
ls_concat :: proc(lists: [][]$T) -> []T {

	total_elements := 0
	for list in lists {
		total_elements += len(list)
	}
	final_list := make([dynamic]T, 0, total_elements)
	for list in lists {
		append(&final_list, ..list)
	}
	return final_list[:]
}

// Returns a list with only the elements for which the
// predicate 'pred' is true.
ls_filter :: proc(l: []$T, pred: proc(element: T) -> bool) -> []T {

	filtered_list := make([dynamic]T, 0, len(l))
	for element in l {
		if pred(element) {
			append(&filtered_list, element)
		}
	}
	return filtered_list[:]
}

// Returns the length of the list.
ls_length :: proc(l: []$T) -> int {

	return len(l)
}

// Returns a list containing the result of calling 'transform'
// on each element of the list.
ls_map :: proc(l: []$T, transform: proc(element: T) -> $U) -> []U {

	mapped_list := make([dynamic]U, 0, len(l))
	for element in l {
		append(&mapped_list, transform(element))
	}
	return mapped_list[:]
}

// Returns the result of applying repeatively  'acc = fn(acc, e)' for each
// element e of the list (left-to-right), initializing 'acc' with 'initial_value'.
ls_foldl :: proc(l: []$T, initial_value: $U, fn: proc(acc: U, element: T) -> U) -> U {

	acc := initial_value
	for element in l {
		acc = fn(acc, element)
	}
	return acc
}

// Returns the result of applying repeatively  'acc = fn(acc, e)' for each
// element e of the list (right-to-left), initializing 'acc' with 'initial_value'.
ls_foldr :: proc(l: []$T, initial_value: $U, fn: proc(acc: U, element: T) -> U) -> U {

	acc := initial_value
	for i := len(l) - 1; i >= 0; i -= 1 {
		acc = fn(acc, l[i])
	}
	return acc
}

// Returns a list with all the elements of the list in
// reverse order.
ls_reverse :: proc(l: []$T) -> []T {

	reversed_list := make([dynamic]T, 0, len(l))
	for i := len(l) - 1; i >= 0; i -= 1 {
		append(&reversed_list, l[i])
	}
	return reversed_list[:]
}
