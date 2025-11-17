# Concept Roadmap

This document describes the draft for the Odin Track syllabus. It presents a reasonable list of concepts to be presented in the concept tree. As recommended in the [Exercism Syllabus Doc](https://exercism.org/docs/building/tracks/syllabus), the tree will be implemented incrementally and, in the process, the exact list of concepts may change. 

I looked at other tracks and, most of them, have between 35 and 45 concepts in their tree (with some going much higher - C-sharp has 62). Too many concepts may be too intimidating to the student, too few may force us to bundle concepts that would better presented separately. The list below is mostly derived from the Go, Javascript, C++, C-sharp and Swift syllabus. Odin has a number of unique features which will be best addressed in their own unique concepts, for example "Memory Management and Allocators", "Structure of Arrays", "Matrix and SIMD Operations", etc. This increases the number of topics so, to try to keep the number in the 35-45 range, I bundled concepts which have been kept separate in other tracks if I thought they could be presented together. For example, I am grouping integers and floating-point in a single topic (Number).

There are concepts that are more important when getting started with the language (core concepts) and other that can be learned later and are not needed in most of the practice exercises (advanced concepts).

I listed the concepts in the order they should be introduced, with pre-requisite concepts being located higher in the list. Advanced concepts are marked with a `(+)`. They should be developed after the core concepts. There are a couple of places where concepts have circular dependencies (like "Context" and "Memory Management & Allocator"). I picked an order but this may change once we start building the set of exercises.

Also, because Odin is close to Go for most concepts (big differences being interfaces/methods, garbage collection and goroutines), I was planning of checking first if we can borrow heavily from the Go track concept exercises.

Another question is how many exercises should we introduce per concept? The Go track has one exercise per Concept while the C-Sharp track has many exercises per concept. I would suggest a goal of one exercise per concept except when there is too much material to introduce in a single exercise. For example, in the "Arithmetic and Bitwise Operators" concept, we could decide that it is best to have an exercise focus on the arithmetic operators and a second one on the bitwise operators.

## Concepts (43)

There are currently 30 core concepts and 13 advanced concepts. Each section includes the concept name, slug, the concept `uuid`, and the list of Odin syntax elements that should be introduced.

### Basics (`basics`, `4db96bc0-433d-4a29-a1ec-45d37c86dd8d`)

Present a getting-started program with the important parts explained. (Most of the tracks use a version of the lasagna exercise).

Syntax covered: `package`, `proc`, constants, numbers and arithmetic operations, assignment.

### Packages (`packages`, `79d17a9d-6758-40ac-947a-cbd699d8bc1e`)

Explain Odin’s packages, their relation to a directory, how and where to import packages from.

Syntax covered: `package`, `import`,`<package>.<proc>`, `"core:..."`.

### Comments (`comments`, `a3e0a652-52d2-455f-aed0-5cb988b7a592`)

Explain Odin’s comments, single-line, multiple-lines, multiple-lines nested, and documentation comments.

Syntax covered: `//`, `/* ... */`, `///`.

### Numbers (`numbers`, `5e96a6b4-33dc-49d4-8f87-c1eaba0e3b49`)

Explain Odin’s integer and floating point types, their literals, the limited auto-conversions, and the casting from one type to the next.

Syntax covered: `i8`, `i16`, `i32`, `i64`, `i128`, `u8`, `u16`, `u32`, `u64`, `u128`, `int`, `uint`, `f16`, `f32`, `f64`, type size and machine architecture, integer literals (w/ base 2, 8, 16), floating-point literals.

### Arithmetic & Bitwise Operators (`math-ops`, `48dd7d6e-6bb8-43e5-a3b2-2248d42f5aa7`)

Describe Odin’s arithmetic and bitwise operators.

Syntax covered: `+`, `-`, `~`, `*`, `/`, `%`, `%%`, `|`, `&`, `&~`, `<<`, `>>`. compound operators (`+=`, ...).

Note: should we merge this with the "Numbers" concept.

### Booleans (`booleans`, `3d3396c6-ef2b-45bc-8c30-8080786e8dfc`)

Explain Odin’s boolean type, including boolean literals.

Syntax covered: `b8`, `b16`, `b32`, `b63`, `bool`, `true`, `false`.

### Comparison & Logic Operators (`logic-ops`, `8389142c-e713-49d6-859c-5220bf2fab6d`)

Explain Odin’s comparison and logic operators.

Note: same as for the arithmetic operators, should we merge this concept with the "Boolean" concept?

Syntax covered: `==`, `!=`, `<`, `<=`, `>`, `>=`, `&&`, `||`, `!`.

### Strings & Runes (`strings`, `879d6d40-9e0a-4c38-97ce-b9fe5add1dc6`)

Explain Odin’s Strings and Runes, the UTF-8 encoding, the unicode runes, and the string literals (including raw strings). Explain that Odin’s strings have a built-in length and hint to the fact that Odin has a zero-terminated string type for interfacing with C (will be explained in Foreign System Interface).

Since there is no separate topic, this should cover string formatting.

Note: there is also support for UTF-16 since this is Windows and JavaScript internal representation. Note sure how much we want to touch on that in this topic.

Syntax covered: `string`, string literal, `rune`, rune literal (w/ unicode notation), `len()`, `+`, `fmt`, `strings`.

### Variables (`variables`, `66468f96-2ae5-43a8-a11c-65a0a26cbf05`)

Explain Odin’s variable definitions and scope, including type inference, forced initialization to a zero value if one is not provided. Odin doesn’t have a concept of immutable variables like Rust and other modern languages.

Syntax covered: `<name>:[type]=[value]`, `<name>=value`.

### Constants (`constants`, `ffcb8c2e-5471-405f-beeb-58afeebe29c6`)

Explain Odin’s constant as a compile-time artifact (not an immutable runtime value). Explain that Odin constants support type inference and use Untyped Types. Explain how Untyped Types are coerced to concrete types when a constant is assigned.

Syntax covered: `<name>:[type]:value`, value can be numbers, booleans, strings, procedures, composite type literals, untyped types.

### Control Flow: Conditionals (`conditionals`, `a4a8efb6-8cae-4ef3-9f35-c4ce0a6aeaeb`)

Describe Odin conditional control flows with the if-then-else and switch statements. Explain that there are no parenthesis around the conditions but that curly braces are always required.

Note: There is the do statement when the body of the conditional statement is a single expression, I have the impression that this is being de-emphasized in modern Odin but if we skip it and the user encounter it, they may be confused.

Explain how switch statements on enums must cover all the cases or use a `#partial` directive. Explain the default switch case (`case:`).

Syntax covered: `if-else if-else`, `switch-case`, `#partial`, `<val_true> if <cond> else <val_false>`, `<cond> ? <val_true> : <val_false>`.

### Pointers (`pointers`, `5212b8c1-c8ff-455c-a458-3c34725d9700`)

Discuss the syntax of pointers and pointers dereference in Odin as well as the notation for address. Discuss how they can be used in dynamic containers, procedure parameters and to get dynamic memory. Explain that Odin doesn’t support pointer arithmetic, including pointer indexing (`[]`).

Note: Odin has a type supporting pointer indexing (multi-pointer) but this is used by the Foreign System Interface and should be discussed there.

Note: This concept was moved up so we can discuss passing parameters by reference in the "Procedures" concept and explain `new()` and `free()` in the "Memory Management" concept below.

Syntax covered: `^<type>`, `<value>^`, `&<value>`, `uintptr`, `rawptr`(may belong in the `ffi` concept).

### Procedures (`procedures`, `ba5631e3-b6ee-4fe8-9179-0fc68753ac3f`)

Explain how Odin’s “functions” are called procedures, describe the syntax of the procedures, the fact that they can be nested, but that there are no closures in Odin.

Explain how parameters are passed by-value but can also be passed by reference (which is why we moved the "Pointer" concept up).

Explain how a procedure can have multiple return values but how these are not tuples.

Syntax covered: `<name> :: proc(<params>) -> (<return types>)`, `return`, anonymous procedures, nested procedures.

### Control Flow: Iteration (`loops`, `1992331e-0e01-4d14-8ad2-8e807c595f77`)


Explain how Odin has only for loops but the for can be a C-like statement (with initialization, condition, and increment), a for-in (on a container type), a while loop (if only a condition is provided), or an infinite loop.

Describe how to get out of a loop early using break, continue and the use of label to get out of multiple nested loops at once.

Explain that, when iterating on a container type with for-in, you get a copy of the element and any change will not be reflected in the original =, unless you iterate on the address of the elements (`for &element in container { …}`).

Syntax covered: `for i:=0; i < N; i +=1 {...}`, `for element in list {...}`, `for i in 0..<N {...}`, `for {...}`, `for <cond> { ...}`, `break [<label>]`, `continue [<label>]`, `<label>:`.

### Recursion (`recursion`, `e2c3169a-8c08-45f5-b5d9-a3478e1cbfe4`)

Odin, like 99% of the languages supports recursion (but not tail-recursion). Is this worth presenting as a separate topic? For readers who are beginners, that may be good.

No new syntax.

### Default Parameters, Named Arguments and Return Values (`parameters`, `61a3bba1-4e83-4a88-ba8c-5a5ba93a332d`)

Explain how we can setup default values for some of a procedure parameters. Show that the parameters can be called out of order if associated with their names.

Explain how we can have named return values and that they are initialized to their type zero value. Explain that a procedure with named return values can use a naked return and that a return is required at the end of the procedure.

Syntax covered: default parameters, named return values, naked `return`.

### Arrays (`arrays`, `5bce87f3-b3c6-45f3-94a9-a3fbc3013ba5`)

Explain Odin’s syntax for fixed sized arrays. Explain that the arrays carry their own size and that a lot of the arithmetic operators can be applied to arrays. Discuss multi-dimensional arrays.

Syntax covered: `[<N>]<type>`, `[?]{...}`, `[<N>]<type>{...}`, `for in`.

### Structs (`structs`, `e1b28ab8-c966-4682-ad75-04c21d333c12`)

Describe the `struct` as the main product type for Odin. Describe how to create `struct` literals and how you can omit the type prefix if the compiler knows which type is needed (variable assignments or procedure parameters).

Syntax covered: `<name> :: struct {...}`.

### Enumerations (`enums`, `a8cb857f-d94a-4608-b6c4-55c892883beb`)

Describe Odin’s enumeration type and its relation to integer values (that may require the concept of type conversion which is lower in the list).

Syntax covered: `<name> :: enum {...}`, switch on enum.

### Unions (`unions`, `f2dda6a2-7cd1-464d-975a-571b9b0d8b29`)

Explain that unions are Odin’s main sum type and that they carry an implicit tag (unlike C unions). Describe how you can use a switch statement to process the different types included in the union.

Syntax covered: <name> :: union {...}`, switch on union.

### Error Handling (`errors`, `1d25068d-8760-45e0-bfe4-cd9c537ac470`)

Explain how Odin doesn’t support exception but can use any type as error type (often enums or unions but this needs to wait for these concepts). This is supported by the capability to return multiple values with the last one often being an error.

Show examples of using an union to represent all the errors reported by a procedure.

Syntax covered: since errors are types, there is no special syntax to introduce here.

### (+) Enumerated Arrays (`enum-arrays`, `52b4234e-2238-446d-b2be-f1d844eb581f`)

Discuss how you can index Odin’s fixed arrays with an enumerations and how this can be used as a “kind of static” map or with switch statements.

Syntax covered: `<name> :: [<enum type>]<type>`

### (+) Bit Sets (`bit-sets`, `99f9d844-08bd-4bd2-a66c-6c8d9adad1b0`)

Explain how Odin can model finite sets of elements using a Bit Set with the elements being an integer range, a character range, or an enumeration. Discuss how the set behaves like a mathematical set (no duplicate elements) and list the different operators that act on sets and how to add/remove elements from the set.

Syntax covered: `bit_set[<enum type>]`, `bit_set[<range>]`, `in`, `not_in`, `+=`, `-=`, `&`, `|`, `+`, `-`.

### Implicit Context (`context`, `6c451ee0-0def-45a2-a09d-07fde884c901`)

Explain how the context is an implicit parameter passed to Odin callee by its caller. Explain that the context includes the general and temp allocator (to be discussed later) but can also contain other data. Show an example with other data.

Note: After some struggles, I moved this concept forward so it is before the concept on allocators. (I may change my mind again but I think it leaves too many things unsaid if presented after memory management). This should be a really short chapter, just introducing the fact that each call has an implicit parameter , copied down but not back up.

Syntax covered: `context` and content of context (`allocator`, `temp_allocator`, `assertion_failure_proc`, `logger`, `random_generator`, `user_ptr`, `user_index`).

### Memory Management & Allocators (`memory-management`, `19f17b53-909d-42fa-89a9-cc4b2bac82a3`)

Discuss Odin manual memory management through allocators. Explain that Odin provides different allocators to group dynamic variables with the same lifetime in the same allocator so that they can be deallocated together. Introduce the arena allocator. Describe how procedure that dynamically allocate memory take an allocator parameter (often defaulted)

Discuss how the context provides two allocators: the default allocator and the temp allocator and how they can be manipulated. Also show that they are typically used to provide default values to allocator parameters.

Introduce the temporary allocator and `free_all()`, explain how this is useful for a loop or game Frame.

Note: it is possible to go too far down this rabbit hole, we need to tread lightly here.

Note: The only type we can use at this point in the concept tree is `string`. We can use `fmt.aprintf()` and `fmt.eprintf()` for the examples using the default and temporary allocators.

Explain the topic of `new()` and `free()` for pointer types and broach the subject of `make()` and `delete()` for built-in types containing pointers (to be discussed later with `maps`, dynamic arrays, and slices).

Syntax covered: `new()`, `free()`, `make()`, `destroy()`, `free_all()`, `arena`. 

### Defer Statement (`defer`, `8e3a2406-d74f-4ae3-8a0f-24b54803d67c`)

Explain that the defer statement allows us to define code that is always executed when the current scope exits. Show how this allows us to group statement allocating and freeing resources close together.

Syntax covered: `defer`.

### Slices (`slices`, `ada74db4-af74-41b7-bd1d-06f104a91e02`)

Explain how slices are front-store for fixed sized arrays and allow procedures to be defined on arrays of any size.

Show how to allocate a slice with `make()`, release it with `delete()` and how to use `append()` to grow them. Explain that we can loop on slices like on arrays and that multiple slices defined on the sam array will alias that array.

Syntax covered: `[]<type>`, `<value>[<start index>:<stop index>]`, `[:]`. `append()`, `make()`, `delete()`, `for in`.

### Dynamic Arrays (`dynamic-arrays`, `ff729831-76fa-45b4-be37-c73a0e226e01`)

Describes the syntax for Odin’s dynamic array. Explain how to allocate and free them, and how to use `append()` to add elements. Discuss the notion of length vs. capacity.

Syntax covered: `[dynamic]<type>`. `append()`, `make()`, `delete()`.

### Maps (`maps`, `7c5ee7f5-48bd-4c1c-930a-9a0a19d794b8`)

Explain the built-in map type, how it is defined and how it is allocated and freed. Explain how to check if a key is in the map and how to iterate on all (key, value) pairs.

Syntax covered: `map[<key type>]<value type>`, `<map name>[<key>]`, `for in`.

### Type Conversions (`casts`, `aa9965bd-1e5a-4923-8be5-e88858f6fe83`)

Explain the different types of cast syntax in Odin and how this can be used for numeric types and enums. Explain the `transmute()` operator as a blind cast between types of the same size.

Syntax covered: `cast(<type>)<value>`, `type(<value>)`, `transmute(<type>)<value>`

### First Class Procedures (`first-class-procedures`, `90cc1b49-bb8a-4c25-b0d4-7e5e06820b8d`)

Explain how procedures are first class in Odin and how they can be passed as arguments to other procedures, stores in variables and composite types. They can also be used as return values but, since Odin, doesn’t support closures, there are limit to what you can do with them in this case.

We could describe the concept of vtables in Odin and the special syntax associated with calling methods in tables (`->`). This is an advanced topic so may be better split and discussed at a lower point in the concept tree.

No new Syntax in this concept.

### Parametric Polymorphism aka. Generics (`generics`, `afdb4afd-f262-47e3-b0f0-f26ea91cd32b`)

Introduce Odin’s syntax to define compile-time values and type parameters that can be used to generalize types and procedures.

Syntax covered: `$`, `typeid`, `where` clause, specialization (`$T/[dynamic]$E`). 

### Composition (`composition`, `98cea22f-cade-47a6-bd94-f6f13983421c`)

Explain how the `using` statement can be used with `struct` to implement composition (type nesting) and how the “nester” type can access the “nested” fields and be passed to procedure arguments expecting a “nestee” type.

Syntax covered: `using`.

### (+) `or_…` statements (`or-statements`, `81758e49-a550-4b5e-b1bc-d6c8213910cc`)

Discuss the `or_else`, `or_return`, `or_continue`, and `or_break` operators and how they can be used to simplify Error Handling. Explain how the first two requires the procedure using them to use named parameters.

Syntax covered: `or_else`, `or_return`, `or_continue`, `or_break`.

### Variadic Parameters (`variadic-parameters`, `46cc7e5d-0e1c-47f3-9e65-36ece4bffc8f`)

Explain Odin’s syntax for variadic parameters, how slice values can be passed as a set of variadic parameters and give an example of a variadic procedure where the variadic argument is passed down to a nested variadic procedure (use `fmt.printf(…)` as the nested procedure).

Syntax covered: `..<type>`, `..<value>`, `for in`

### (+) Explicit Procedure Overloading (`explicit-overloading`, `c9062752-fc34-46db-b112-dc3a413867c8`)

Describe how Odin doesn’t support implicit procedure overloading but allow for explicit overloading.

Syntax covered: `<name> :: proc {...}`

### (+) Matrix and SIMD Operations (`matrix`, `58a82ae3-46bb-4b21-bfc9-4f1c40803443`)
 
Describe the matrix type, matrix operations and explains how the compiler uses SIMD instruction for matrix operations.

Syntax covered: `matrix[<N>,<M>]`, `complexN`, `quaternionN`, `#simd[<N>]<type>`.

### (+) Structure of Arrays (`structure-of-arrays`, `cc399bab-d16a-4302-86e9-6e45310b5039`)

Explain how data-oriented programming often requires arrays of `struct` to be converted to `struc` of arrays to avoid cache misses. Show how Odin allows a simple directive to achieve this while leaving the programmer to deal with a friendlier array of `struc` syntax.

Syntax covered: `#soa`.

### (+) Conditional Compilation (`conditional-compilation`, `30d11f54-af0a-4299-b374-50982b02c836`)

Show how Odin supports conditional compilation with `when` to support multiple platforms.

Note: we may need to explain how Odin defines dependencies on specific libraries right in the source code.

Note: I am not sure how much of that can be exercised in the context of Exercism test-runner infrastructure.

### (+) Foreign Function Interface (`ffi`, `aaf2e00b-ae08-4924-9d92-f1e25201ae68`)

Explain how Odin’s supports interfacing with any library that has a C ABI compatible interface. Show a simple example of calling either a user defined library or a function of the C library (probably posix to be available on the test-runner platform).

Shows how Odin has C specific types that must be used for interfacing with C libraries (especially zero-terminated `cstring`)

Explain how Odin let you specify the coding convention for an interface function.

Syntax covered: `foreign import`, calling conventions, c types, `"core:c"`.

### (+) Bit fields (`bit-fields`, `55ee8e37-cc62-4ea5-af46-1e16193bb1b5`)

Explain how Odin let you specify the bit allocation of a `struct` within a segment of memory and how this can be used to specify exact memory layout when dealing with external interfaces.

Syntax covered: `<name> :: bit_field <type> {...}`.

### (+) Attributes and Directives (`attributes-directives`, `24074068-85a2-4884-9aa2-830c5077bd84`)

Explain the difference between attributes (`@`) and directives (`#`) and introduce a couple of the most useful ones.

Syntax covered: `@(<attribute>)`, `#directive`.

### (+) Tracking Allocator (`mem-tracking`, `649e39bb-db76-4058-945d-c4ffa813c45a`)

Show how to use the tracking allocator to check for memory leaks and incorrect releases in your program.

Syntax covered: `mem.Tracking_Allocator`.

### (+) Test Framework (`testing`, `e66f615c-9485-49e7-9cbf-6e804e265100`)

Describe Odin’s facilities to write and run tests. Discuss the fact that `odin test` run with the tracking allocator turned on.

Syntax covered: `"core:testing"`, `testing.expect...()`

### (+) Regular Expression (`regex`, `da6ef497-b0e8-49f3-9a58-0f969f315bee`)

This is really a library but very useful for any real-life work. Describes Odin `regex` package and how to use it.

Syntax covered `"core:text/regex"`

### (+) Concurrency (`concurrency`, `c0234788-2918-4e94-9d40-ceaf3856d30a`)

Explain how Odin supports concurrency via thread and synchronization objects.

Syntax covered: `"core:thread"`, `"core:sync"`.

