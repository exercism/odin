package custom_set

// Replace the definition of Set with your own.
// Note: It doesn't have to be a `struct`.
Set :: struct {}

new_set :: proc(elements: ..int) -> Set {
	// Implement this procedure.
	set: Set
	return set
}

to_string :: proc(s: Set) -> string {
	// Implement this procedure.
	return ""
}

is_empty :: proc(s: Set) -> bool {
	// Implement this procedure.
	return false
}

contains :: proc(s: Set, element: int) -> bool {
	// Implement this procedure.
	return false
}

is_subset :: proc(s: Set, other: Set) -> bool {
	// Implement this procedure.
	return false
}

is_disjoint :: proc(s: Set, other: Set) -> bool {
	// Implement this procedure.
	return false
}

equal :: proc(s: Set, other: Set) -> bool {
	// Implement this procedure.
	return false
}

add :: proc(s: ^Set, elements: ..int) {
	// Implement this procedure.
}

intersection :: proc(s: Set, other: Set) -> Set {
	// Implement this procedure.
	set: Set
	return set
}

difference :: proc(s: Set, other: Set) -> Set {
	// Implement this procedure.
	set: Set
	return set
}

// union is a reserved word in Odin, using join instead.
join :: proc(s: Set, other: Set) -> Set {
	// Implement this procedure.
	set: Set
	return set
}
