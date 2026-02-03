package list_ops

// All procedures use prefix `ls_` to avoid conflict
// with Odin built-in `append()` and `map`.

// Returns a new list with 'other' appended to 'l'.
ls_append :: proc(l: []$T, other: []T) -> []T {
	// Implement this procedure.
	return nil
}

// Creates a new list by concatenating all the argument lists.
ls_concat :: proc(lists: [][]$T) -> []T {
	// Implement this procedure.
	return nil
}

// Returns a list with only the elements for which the
// predicate 'pred' is true.
ls_filter :: proc(l: []$T, pred: proc(element: T) -> bool) -> []T {
	// Implement this procedure.
	return nil
}

// Returns the length of the list.
ls_length :: proc(l: []$T) -> int {
	// Implement this procedure.
	return -1
}

// Returns a list containing the result of calling 'transform'
// on each element of the list.
ls_map :: proc(l: []$T, transform: proc(element: T) -> $U) -> []U {
	// Implement this procedure.
	return nil
}

// Returns the result of applying repeatively  'acc = fn(acc, e)' for each
// element e of the list (left-to-right), initializing 'acc' with 'initial_value'.
ls_foldl :: proc(l: []$T, initial_value: $U, fn: proc(acc: U, element: T) -> U) -> U {
	// Implement this procedure.
	zero: U
	return zero
}

// Returns the result of applying repeatively  'acc = fn(acc, e)' for each
// element e of the list (right-to-left), initializing 'acc' with 'initial_value'.
ls_foldr :: proc(l: []$T, initial_value: $U, fn: proc(acc: U, element: T) -> U) -> U {
	// Implement this procedure.
	zero: U
	return zero
}

// Returns a list with all the elements of the list in
// reverse order.
ls_reverse :: proc(l: []$T) -> []T {
	// Implement this procedure.
	return nil
}
