package forth

import "core:slice"
import "core:strconv"
import "core:strings"

// Forth is typically low-level and implement its own buffer, dictionary and virtual
// machine instruction set.
//
// Since we are using Go, we will make full use of the provided map, closures,
// and first order functions facilities it provides.

Error :: enum {
	None,
	Not_Enough_Elements_On_Stack,
	Divide_By_Zero,
	Unknown_Word,
	Compile_Word_Redefinition_Not_Allowed,
	Number_Redefinition_Not_Allowed,
	Nested_Definitions_Not_Allowed,
	Unknown_Word_Used_In_Definition,
	End_Of_Definition_Missing,
	Unimplemented,
}

// Instruction define a forth word, including the ones defined by the user.
Primitive_Instruction :: #type proc(vm: ^Forth_VM) -> Error

User_Defined_Instruction :: []Instruction

Instruction :: union #no_nil {
	Primitive_Instruction,
	User_Defined_Instruction,
	int,
}

Forth_VM :: struct {
	// Stack represents the Forth stack where instructions take their arguments and post their
	// result.
	stack: Stack,
	// Dictionary contains the definition of all the Forth words (including the built-in words).
	dict:  map[string]Instruction,
}

// initializes the Forth interpreter.
// It clears the stack, the dictionary and define the built-in words.
create_forth_vm :: proc() -> Forth_VM {

	vm: Forth_VM
	vm.stack = create_stack()
	vm.dict = make(map[string]Instruction)

	// Define the built-in functions (except ":" and ";" which are hard-coded
	// in the interpreter).
	vm.dict["+"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Not_Enough_Elements_On_Stack
		}
		push(&v.stack, pop(&v.stack) + pop(&v.stack))
		return .None
	}

	vm.dict["-"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Not_Enough_Elements_On_Stack
		}
		a, b := pop(&v.stack), pop(&v.stack)
		push(&v.stack, b - a)
		return .None
	}

	vm.dict["*"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Not_Enough_Elements_On_Stack
		}
		push(&v.stack, pop(&v.stack) * pop(&v.stack))
		return nil
	}

	vm.dict["/"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Not_Enough_Elements_On_Stack
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
			return .Not_Enough_Elements_On_Stack
		}
		push(&v.stack, peek(v.stack, 0))
		return .None
	}

	vm.dict["drop"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 1 {
			return .Not_Enough_Elements_On_Stack
		}
		pop(&v.stack)
		return .None
	}

	vm.dict["swap"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Not_Enough_Elements_On_Stack
		}
		a, b := pop(&v.stack), pop(&v.stack)
		push(&v.stack, a)
		push(&v.stack, b)
		return .None
	}

	vm.dict["over"] = proc(v: ^Forth_VM) -> Error {
		if size(v.stack) < 2 {
			return .Not_Enough_Elements_On_Stack
		}
		push(&v.stack, peek(v.stack, 1))
		return nil
	}
	return vm
}

destroy_forth_vm :: proc(v: ^Forth_VM) {

	destroy_stack(&v.stack)
	for _, instr in v.dict {
		switch code in instr {
		case Primitive_Instruction:
		// Nothing to delete
		case User_Defined_Instruction:
			delete(code)
		case int:
		// Nothing to delete
		}
	}
	delete(v.dict)
}

// evaluate takes a number of lines of input and returns the resulting stack
// or an error if the execution failed.
evaluate :: proc(input: []string) -> (output: []int, error: Error) {

	vm := create_forth_vm()

	defer {
		destroy_forth_vm(&vm)
		free_all(context.temp_allocator)
	}
	eval(&vm, input) or_return

	output = slice.clone(vm.stack.data[:])
	return
}

eval :: proc(v: ^Forth_VM, input: []string) -> Error {

	for line in input {
		// This Forth version is case insensitive.
		lc_line := strings.to_lower(line, context.temp_allocator)
		words := strings.split(lc_line, " ", context.temp_allocator)
		interp(v, words) or_return
	}
	return .None
}

// Interpret executes the sets of provided words.
// If returns an error if it cannot interpret a word or an error occurs
// during a word execution.
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
		error = .Compile_Word_Redefinition_Not_Allowed
		return
	}
	// Not allowed to redefine numbers.
	if _, is_number := strconv.parse_int(wordname, 10); is_number {
		error = .Number_Redefinition_Not_Allowed
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
			error = .Nested_Definitions_Not_Allowed
			return
		case word == ";":
			end_of_def = true
			next_idx = i + 1
			break def_loop
		case:
			instr, ok := v.dict[word]
			if !ok {
				error = .Unknown_Word_Used_In_Definition
				return
			}
			append(&code, instr)
		}
	}
	if !end_of_def {
		error = .End_Of_Definition_Missing
		return
	}
	v.dict[wordname] = code[:]
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

import "core:fmt"
main :: proc() {

	input := [?]string{": countup 1 2 3 ;", "countup"}
	result, error := evaluate(input[:])
	defer delete(result)
	fmt.println(error, result)
}
