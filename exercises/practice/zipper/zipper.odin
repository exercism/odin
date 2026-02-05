package zipper

// A Binary Tree representation
Tree :: ^Node

// A single Node within the Binary Tree
Node :: struct {
	value: int,
	left:  Tree,
	right: Tree,
}

// The Zipper data structure that keeps track of the focus and the previous operations.
Zipper :: struct {
	tree:  Tree,
	trail: Trail,
}

// The set of previous operations applied to the tree.
Trail :: ^Step

// A single operation applied to the tree.
Step :: struct {
	action: Action,
	value:  int,
	tree:   Tree,
	next:   Trail,
}

// The possible operations applied to the tree.
Action :: enum {
	Right,
	Left,
}

// Get a zipper out of a tree, the focus is on the root node.
zip_from_tree :: proc(t: Tree) -> Zipper {
	// Implement this procedure.
	return Zipper{}
}

// Get the tree out of the zipper.
zip_to_tree :: proc(z: Zipper) -> Tree {
	// Implement this procedure.
	return nil
}

// Get the value of the focus node.
zip_value :: proc(z: Zipper) -> int {
	// Implement this procedure.
	return 0
}

// Move the focus to the left child of the focus node, returns a new zipper.
// If there is no left child, return a zero value Zipper.
zip_left :: proc(z: Zipper) -> Zipper {
	// Implement this procedure.
	return Zipper{}
}

// Move the focus to the right child of the focus node, returns a new zipper.
// If there is no right child, return a zero value Zipper.
zip_right :: proc(z: Zipper) -> Zipper {
	// Implement this procedure.
	return Zipper{}
}

// Move the focus to the parent of the focus node, returns a new zipper.
// If there is no parent, return a zero value Zipper.
zip_up :: proc(z: Zipper) -> Zipper {
	// Implement this procedure.
	return Zipper{}
}

// Set the value of the focus node, returns a new zipper.
zip_set_value :: proc(z: Zipper, value: int) -> Zipper {
	// Implement this procedure.
	return Zipper{}
}

// Set the left subtree of the focus node, returns a new zipper.
zip_set_left :: proc(z: Zipper, subtree: Tree) -> Zipper {
	// Implement this procedure.
	return Zipper{}
}

// Set the right subtree of the focus node, returns a new zipper.
zip_set_right :: proc(z: Zipper, subtree: Tree) -> Zipper {
	// Implement this procedure.
	return Zipper{}
}
