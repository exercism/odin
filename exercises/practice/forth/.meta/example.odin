package forth

import "core:slice"
import "core:strconv"
import "core:strings"

// Forth is a low-level stack-based programming language. Words (primitives and user-defined)
// are kept in a dictionary and pretty-much every word can be redefined.
// See https://www.forth.org/index.html to learn more.

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

// Instruction define a forth word, including the ones defined by the user.
Primitive_Instruction :: #type proc(vm: ^Forth_VM) -> Error

User_Defined_Instruction :: []Instruction

// Note: In languages that support closure (like Go) we can
// go by with just one type of instruction (`proc(vm: ^Forth_VM) -> Error`).
// In Odin we can 'generate' procedures at runtime with a non-constant payload
// like an integer or a list of instructions so we do use an`union` instead.
Instruction :: union #no_nil {
	Primitive_Instruction,
	User_Defined_Instruction,
	int,
}

Forth_VM :: struct {
	// The Forth stack where instructions take their arguments and post their result.
	stack:     Stack,
	// The definition of all the Forth words (including the built-in words).
	dict:      map[string]Instruction,
	// List of all the user defined words.
	// They will need to be de-allocated when we destroy the VM.
	// If we were just deleting words in the dictionary, we would miss the user defined words that have
	// been redefined (i.e. their body still exist, but they can't be looked up in the dictionary)
	user_defs: [dynamic]User_Defined_Instruction,
}

// Creates a Forth Virtual Machine.
create_forth_vm :: proc() -> Forth_VM {

	vm: Forth_VM
	vm.stack = create_stack()
	vm.dict = make(map[string]Instruction)
	vm.user_defs = make([dynamic]User_Defined_Instruction)

	// Define the built-in functions (except ":" and ";" which are hard-coded
	// in the interpreter).
	vm.dict["+"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Stack_Underflow
		}
		push(&v.stack, pop(&v.stack) + pop(&v.stack))
		return .None
	}

	vm.dict["-"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Stack_Underflow
		}
		a, b := pop(&v.stack), pop(&v.stack)
		push(&v.stack, b - a)
		return .None
	}

	vm.dict["*"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Stack_Underflow
		}
		push(&v.stack, pop(&v.stack) * pop(&v.stack))
		return nil
	}

	vm.dict["/"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Stack_Underflow
		}
		if peek(v.stack, 0) == 0 {
			return .Divide_By_Zero
		}
		a, b := pop(&v.stack), pop(&v.stack)
		push(&v.stack, b / a)
		return .None
	}

	vm.dict["dup"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 1 {
			return .Stack_Underflow
		}
		push(&v.stack, peek(v.stack, 0))
		return .None
	}

	vm.dict["drop"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 1 {
			return .Stack_Underflow
		}
		pop(&v.stack)
		return .None
	}

	vm.dict["swap"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Stack_Underflow
		}
		a, b := pop(&v.stack), pop(&v.stack)
		push(&v.stack, a)
		push(&v.stack, b)
		return .None
	}

	vm.dict["over"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Stack_Underflow
		}
		push(&v.stack, peek(v.stack, 1))
		return nil
	}
	return vm
}

destroy_forth_vm :: proc(v: ^Forth_VM) {

	destroy_stack(&v.stack)
	for &def in v.user_defs {
		delete(def)
	}
	delete(v.user_defs)
	delete(v.dict)
}

// Evaluates fires a Forth VM and feeds it the user input lines.
// It return the state of the Forth VM stack and an error if one occurs.
evaluate :: proc(input: ..string) -> (output: []int, error: Error) {

	vm := create_forth_vm()

	defer {
		destroy_forth_vm(&vm)
		free_all(context.temp_allocator)
	}
	eval(&vm, input) or_return

	output = slice.clone(vm.stack.data[:])
	return
}

// Evaluates the user input.
eval :: proc(v: ^Forth_VM, input: []string) -> Error {

	for line in input {
		// This Forth version is case insensitive.
		lc_line := strings.to_lower(line, context.temp_allocator)
		words := strings.split(lc_line, " ", context.temp_allocator)
		interp(v, words) or_return
	}
	return .None
}

// Interprets the input words one at a time.
// - Integers are pushed on the stack
// - : ... ; compiles a new word
// Anything else is interpreted as a word to be looked-up and executed
interp :: proc(v: ^Forth_VM, words: []string) -> Error {

	for idx := 0; idx < len(words); idx += 1 {
		word := words[idx]
		number, is_number := strconv.parse_int(word, 10)
		switch {
		case is_number:
			push(&v.stack, number)
		case word == ":":
			next_idx := compile(v, idx + 1, words) or_return
			// Skip ahead to the token after ';'
			idx = next_idx
		case:
			instr, ok := v.dict[word]
			if !ok {
				return .Unknown_Word
			}
			exec(v, instr) or_return
		}
	}
	return .None
}

// Executes an instruction, arguments are taken from the stack
// and return value put on the stack.
exec :: proc(v: ^Forth_VM, instr: Instruction) -> Error {

	switch code in instr {
	case Primitive_Instruction:
		code(v) or_return
	case User_Defined_Instruction:
		for subinstr in code {
			exec(v, subinstr) or_return
		}
	case int:
		push(&v.stack, code)
	}
	return .None
}

// compiles the word coming next in the input.
// It returns the index in the input where the interpreter should
// resume or an error if compilation failed.
compile :: proc(v: ^Forth_VM, idx: int, words: []string) -> (next_idx: int, error: Error) {

	// When we redefine a word, previous word definition using the old
	// definition will still work since they contain a reference to the old
	// instruction in their code. Words defined after this one, will lookup
	// and use the new definition.
	//
	// If compilation is successful, we build on the fly an instruction that
	// will execute the definition in order.
	//
	// Note that this implementation prevents us from implementing the Forth word "forget".
	wordname := words[idx]
	// For now doesn't allow redefinition of ":" and ";".
	if wordname == ":" || wordname == ";" {
		error = .Cant_Redefine_Compilation_Word
		return
	}
	// Not allowed to redefine numbers.
	if _, is_number := strconv.parse_int(wordname, 10); is_number {
		error = .Cant_Redefine_Number
		return
	}
	end_of_def := false
	code := make([dynamic]Instruction)

	def_loop: for i := idx + 1; i < len(words); i += 1 {
		word := words[i]
		number, is_number := strconv.parse_int(word, 10)
		switch {
		case is_number:
			append(&code, number)
		case word == ":":
			error = .Cant_Nest_Definitions
			return
		case word == ";":
			end_of_def = true
			next_idx = i + 1
			break def_loop
		case:
			instr, ok := v.dict[word]
			if !ok {
				error = .Unknown_Word
				return
			}
			append(&code, instr)
		}
	}
	if !end_of_def {
		error = .Incomplete_Definition
		return
	}
	def := code[:]
	append(&v.user_defs, def)
	v.dict[wordname] = def
	return
}

// Simple Stack for the Forth VM.
// There is no protection against accessing an empty stack because
// this is taken care of in the Forth Virtual Machine.
Stack :: struct {
	data: [dynamic]int,
}

create_stack :: proc() -> Stack {

	return Stack{make([dynamic]int)}
}

destroy_stack :: proc(s: ^Stack) {

	delete(s.data)
}

size :: proc(s: Stack) -> int {

	return len(s.data)
}

pop :: proc(s: ^Stack) -> int {

	stack_len := len(s.data)
	value := s.data[stack_len - 1]
	unordered_remove(&s.data, stack_len - 1)
	return value
}

peek :: proc(s: Stack, nth_pos: int) -> int {

	stack_len := len(s.data)
	return s.data[stack_len - nth_pos - 1]
}

push :: proc(s: ^Stack, value: int) {

	append(&s.data, value)
}
