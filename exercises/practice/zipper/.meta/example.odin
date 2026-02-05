package zipper

// A Binary Tree representation
Tree :: ^Node

// A single Node within the Binary Tree
Node :: struct {
	value: int,
	left:  Tree,
	right: Tree,
}

node :: proc(value: int, left: Tree = nil, right: Tree = nil) -> Tree {

	nd := new(Node)
	nd.value = value
	nd.left = left
	nd.right = right
	return nd
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

step :: proc(action: Action, value: int, tree: Tree, trail: Trail) -> Trail {

	step := new(Step)
	step.next = trail
	step.action = action
	step.value = value
	step.tree = tree

	return step
}

// The possible operations applied to the tree.
Action :: enum {
	Right,
	Left,
}

// Get a zipper out of a tree, the focus is on the root node.
zip_from_tree :: proc(t: Tree) -> Zipper {

	return Zipper{tree = t}
}

zip_from_trail :: proc(t: Tree, step: Step) -> Tree {

	new_tree: Tree

	switch step.action {
	case .Left:
		new_tree = node(step.value, left = t, right = step.tree)
	case .Right:
		new_tree = node(step.value, left = step.tree, right = t)
	}
	return new_tree
}

// Get the tree out of the zipper.
zip_to_tree :: proc(z: Zipper) -> Tree {

	return zip_rebuild_tree(z.tree, z.trail)
}

zip_rebuild_tree :: proc(tree: Tree, trail: Trail) -> Tree {

	if trail == nil { return tree }

	return zip_rebuild_tree(zip_from_trail(tree, trail^), trail.next)
}

// Get the value of the focus node.
zip_value :: proc(z: Zipper) -> int {

	if z.tree == nil { return 0 }

	return z.tree.value
}

// Move the focus to the left child of the focus node, returns a new zipper.
// If there is no left child, return a zero value Zipper.
zip_left :: proc(z: Zipper) -> Zipper {

	if z.tree == nil { return Zipper{} }

	new_trail := step(.Left, z.tree.value, z.tree.right, z.trail)
	return Zipper{tree = z.tree.left, trail = new_trail}
}

// Move the focus to the right child of the focus node, returns a new zipper.
// If there is no right child, return a zero value Zipper.
zip_right :: proc(z: Zipper) -> Zipper {

	if z.tree == nil { return Zipper{} }

	new_trail := step(.Right, z.tree.value, z.tree.left, z.trail)
	return Zipper{tree = z.tree.right, trail = new_trail}
}

// Move the focus to the parent of the focus node, returns a new zipper.
// If there is no parent, return a zero value Zipper.
zip_up :: proc(z: Zipper) -> Zipper {

	if z.trail == nil { return Zipper{} }

	return Zipper{tree = zip_from_trail(z.tree, z.trail^), trail = z.trail.next}
}

// Set the value of the focus node, returns a new zipper.
zip_set_value :: proc(z: Zipper, value: int) -> Zipper {

	return Zipper{tree = node(value, left = z.tree.left, right = z.tree.right), trail = z.trail}
}

// Set the left subtree of the focus node, returns a new zipper.
zip_set_left :: proc(z: Zipper, subtree: Tree) -> Zipper {

	return Zipper{tree = node(z.tree.value, left = subtree, right = z.tree.right), trail = z.trail}
}

// Set the right subtree of the focus node, returns a new zipper.
zip_set_right :: proc(z: Zipper, subtree: Tree) -> Zipper {

	return Zipper{tree = node(z.tree.value, left = z.tree.left, right = subtree), trail = z.trail}
}
