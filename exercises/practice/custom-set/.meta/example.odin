package custom_set

import "core:fmt"
import "core:slice"

Marker :: struct {}

Set :: map[int]Marker

MARKER :: Marker{}

new_set :: proc(elements: ..int) -> Set {

	set := make(Set)
	for element in elements {
		set[element] = MARKER
	}
	return set
}

destroy_set :: proc(s: ^Set) {

	delete(s^)
}

to_string :: proc(s: Set) -> string {

	elements, err := slice.map_keys(s)
	// We don't expect the allocator to fail.
	ensure(err == nil)
	defer delete(elements)
	slice.sort(elements)
	return fmt.aprintf("%v", elements)
}

is_empty :: proc(s: Set) -> bool {

	return len(s) == 0
}

contains :: proc(s: Set, element: int) -> bool {

	return element in s
}

is_subset :: proc(s: Set, other: Set) -> bool {

	if len(other) < len(s) { return false }
	for element in s {
		if !contains(other, element) { return false }
	}
	return true
}

is_disjoint :: proc(s: Set, other: Set) -> bool {

	for element in other {
		if contains(s, element) { return false }
	}
	return true
}

equal :: proc(s: Set, other: Set) -> bool {

	if len(s) != len(other) { return false }
	for element in other {
		if !contains(s, element) { return false }
	}
	return true
}

add :: proc(s: ^Set, elements: ..int) {

	for element in elements {
		s[element] = MARKER
	}
}

intersection :: proc(s: Set, other: Set) -> Set {

	inter_set := new_set()
	for element in s {
		if contains(other, element) {
			add(&inter_set, element)
		}
	}
	return inter_set
}

difference :: proc(s: Set, other: Set) -> Set {

	diff_set := new_set()
	for element in s {
		if !contains(other, element) {
			add(&diff_set, element)
		}
	}
	return diff_set
}

// union is a reserved word in Odin, using join instead.
join :: proc(s: Set, other: Set) -> Set {

	union_set := new_set()
	for element in s {
		add(&union_set, element)
	}
	for element in other {
		add(&union_set, element)
	}
	return union_set
}
