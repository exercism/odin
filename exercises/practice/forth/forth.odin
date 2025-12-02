package forth

// Forth is a low-level stack-based programming language. Words (primitives and user-defined)
// are kept in a dictionary and pretty-much every word can be redefined.
//
// See https://skilldrick.github.io/easyforth/ (chapters: Introduction, Adding Some Numbers,
// Defining Words, and Stack Manipulations for material in this exercise).

// Set of Errors returned by `evaluate()`.
Error :: enum {
	None,
	Cant_Nest_Definitions,
	Cant_Redefine_Compilation_Word,
	Cant_Redefine_Number,
	Divide_By_Zero,
	Incomplete_Definition,
	Stack_Underflow,
	Unknown_Word,
	Unimplemented,
}

// Evaluates fires a Forth VM and feeds it the user input lines.
// It return the state of the Forth VM stack and an error if one occurs.
evaluate :: proc(input: ..string) -> (output: []int, error: Error) {
	// Implement this procedure.
	return nil, .Unimplemented
}
