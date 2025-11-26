package linked_list

// Define the content of List.
// (a double-link list must keep track of its head and its tail).
List :: struct {}

// Define the content of Node.
// (for a double-link list, a Node must keep track of its previous and next element).
Node :: struct {}

Error :: enum {
	None,
	Cannot_Shift_empty_List,
	Cannot_Pop_Empty_List,
	Unimplemented,
}

// Create a new list containing 'elements'.
new_list :: proc(elements: ..int) -> List {
	// Implement this procedure.
	return List{}
}

// Deallocate the list
destroy_list :: proc(l: ^List) {
	// Implement this procedure.
}

// Insert a value at the head of the list.
unshift :: proc(l: ^List, value: int) {
	// Implement this procedure.
}

// Add a value to the tail of the list
push :: proc(l: ^List, value: int) {
	// Implement this procedure.
}

// Remove and return the value at the head of the list.
shift :: proc(l: ^List) -> (int, Error) {
	// Implement this procedure.
	return 0, .Unimplemented
}

// Remove and return the value at the tail of the list.
pop :: proc(l: ^List) -> (int, Error) {
	// Implement this procedure.
	return 0, .Unimplemented
}

// Reverse the elements in the list (in-place).
reverse :: proc(l: ^List) {
	// Implement this procedure.
}

// Returns the number of elements in the list
count :: proc(l: List) -> int {
	// Implement this procedure.
	return 0
}

// Delete (only) the first element from the list with the given value.
// If the value is not in the list, do nothing.
delete :: proc(l: ^List, value: int) {
	// Implement this procedure.
}
