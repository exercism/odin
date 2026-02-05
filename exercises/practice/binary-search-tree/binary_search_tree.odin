package binary_search_tree

Tree :: ^Node

Node :: struct {
	value: int,
	left:  Tree,
	right: Tree,
}

destroy_tree :: proc(t: Tree) {
	// Implement this procedure.
}

insert :: proc(t: ^Tree, value: int) {
	// Implement this procedure.
}

sorted_data :: proc(t: Tree) -> []int {
	// Implement this procedure.
	return nil
}
