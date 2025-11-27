package linked_list

List :: struct {
	head: ^Node,
	tail: ^Node,
}

Node :: struct {
	prev:  ^Node,
	next:  ^Node,
	value: int,
}

Error :: enum {
	None,
	Empty_List,
	Unimplemented,
}

// Create a new list containing 'elements'.
new_list :: proc(elements: ..int) -> List {

	list := List{}
	for element, index in elements {
		node := new(Node)
		node.value = element
		node.prev = list.tail
		if index == 0 {
			list.head = node
		} else {
			list.tail.next = node
		}
		list.tail = node
	}
	return list
}

// Deallocate the list
destroy_list :: proc(l: ^List) {

	for node := l.head; node != nil; node = node.next {
		free(node)
	}
}

// Insert a value at the head of the list.
unshift :: proc(l: ^List, value: int) {

	node := new(Node)
	node.value = value
	node.next = l.head
	if l.head != nil {
		l.head.prev = node
	}
	l.head = node
	if l.tail == nil {
		l.tail = node
	}
}

// Add a value to the tail of the list
push :: proc(l: ^List, value: int) {

	node := new(Node)
	node.value = value
	node.prev = l.tail
	if l.tail != nil {
		l.tail.next = node
	}
	l.tail = node
	if l.head == nil {
		l.head = node
	}
}

// Remove and return the value at the head of the list.
shift :: proc(l: ^List) -> (int, Error) {

	if l.head == nil {
		return 0, .Empty_List
	}
	shifted_node := l.head
	defer free(shifted_node)
	if l.head == l.tail {
		l.head = nil
		l.tail = nil
	} else {
		l.head.next.prev = nil
		l.head = l.head.next
	}
	return shifted_node.value, .None
}

// Remove and return the value at the tail of the list.
pop :: proc(l: ^List) -> (int, Error) {

	if l.head == nil {
		return 0, .Empty_List
	}
	poped_node := l.tail
	defer free(poped_node)
	if l.head == l.tail {
		l.head = nil
		l.tail = nil
	} else {
		l.tail.prev.next = nil
		l.tail = l.tail.prev
	}
	return poped_node.value, .None
}

// Reverse the elements in the list (in-place).
reverse :: proc(l: ^List) {

	// Start from the tail and move up to the head,
	// while swapping the nodes 'prev' and 'next' pointers.
	next_node := l.tail
	for next_node != nil {
		n := next_node
		// Increment the node before we modify it so we don't mess
		// up the loop.
		next_node = next_node.prev
		n.prev, n.next = n.next, n.prev
	}
	l.head, l.tail = l.tail, l.head
}

// Returns the number of elements in the list
count :: proc(l: List) -> int {

	n := 0
	for node := l.head; node != nil; node = node.next {
		n += 1
	}
	return n
}

// Delete (only) the first element from the list with the given value.
delete :: proc(l: ^List, value: int) {

	for node := l.head; node != nil; node = node.next {
		if node.value == value {
			defer free(node)
			if node.prev != nil {
				node.prev.next = node.next
			} else {
				l.head = node.next
			}
			if node.next != nil {
				node.next.prev = node.prev
			} else {
				l.tail = node.prev
			}
			return
		}
	}
}
