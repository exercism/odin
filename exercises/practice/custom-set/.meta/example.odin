package custom_set

import "core:slice"
import "core:strings"

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

to_string :: proc(s: Set) -> string {

	// Need to get the set elements in order.
	elements := make([]int, len(s))
	defer delete(elements)
	i := 0
	for element in s {
		elements[i] = element
		i += 1
	}
	slice.sort(elements)

	// Now just write them out
	buf := strings.builder_make()
	strings.write_byte(&buf, '{')
	first := true
	for element in elements {
		if first {
			first = false
		} else {
			strings.write_string(&buf, ", ")
		}
		strings.write_int(&buf, element)
	}
	strings.write_byte(&buf, '}')
	return strings.to_string(buf)
}

is_empty :: proc(s: Set) -> bool {

	return len(s) == 0
}

contains :: proc(s: Set, element: int) -> bool {

	_, ok := s[element]
	return ok
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
