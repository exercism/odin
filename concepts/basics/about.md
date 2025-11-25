# Basics About

The Odin language is a statically typed, imperative language designed as a practical, modern, successor to C.
GingerBill, Odin's creator, wanted a language that fixes most of the C language's annoyances while still providing the same, close-to-the-metal, performance-oriented experience.
Odin includes additional, high-level features for data-programming, efficient memory management and comes with modern tooling.
In addition, it interfaces seamlessly with any library providing a C ABI ([Application Binary Interface][application-binary-interface]).

Odin's compiler suite comes with "battery included": a significant standard library and a set of game-oriented and graphics libraries such as OpenGL, SDL, Direct-X and Raylib.
The compiler is available on Windows, MacOS, and Linux and supports Web Assembly.

In this concept, we will discuss the minimum you need to write a program in Odin: comments, packages, variables, constants, and procedures.

## Comments

Odin uses standard comments from the `C` family.

- Single line comments uses `//`.
- Multi-line comments starts with `/*`, ends with `*/`, and can be nested.
- Documentation comments uses `///` and can be placed before types or procedures definitions.

## Packages

Odin's applications are organized in packages.
A package is a collection of source files (ending in `.odin`) and located in the same directory.
The name of the package must match the last layer of the directory name.
A package defines a set of data types, procedures, variables, and constants which can then be referenced by other packages.
All objects defined in a package are public by default and we will show in a later concept how to keep them private.

Each file in a package must start with a package statement:

```odin
package lasagna
```

Other packages can import the functionality defined in a package using an `import` statement:

```Odin
import "cooking/gears"
```

The import reference the path of the imported package relative to the location of the importing package. In our example,
the Odin files for the `package` gears will be located two sub-directory below the lasagna `package`.

```
lasagna/
  lasagna.odin
  cooking/
    gears/
      kitchen_gears.odin
      outdoor_gears.odin
    ingredients/
      ...
```

If the package belongs to the standard library (`core`), just prefix the package name with `core:` and the compiler will automatically grab the code from the installation.
For example, the standard library `fmt` package can be imported with:

```
import "core:fmt"
```

## Variables

Odin is statically typed and all variables must have a type but Odin supports type inference avoiding unnecessary redundancy.
If a variable is not given an initial value, Odin will initialize it with the zero value for the type.
The variable declaration and initialization form is:

```
<variable-name> : <variable-type> = <initial_value>
```

If the type is omitted, the compiler will infer it from the initial value.
If the initial value is omitted then Odin will use the zero value for the type.


```odin
danny_age : int = 20
jane_age := 18 // inferred type of int based on value 18
newborn_age : int // = 0
```

Variables can be re-assigned using the standard assignment operator `=` as long as the new value matches the variable type.

## Constants

Odin supports values that are evaluated at compile time, they are equivalent to a `C` `#define` statement.
As with variables, constants have a type but constant types have a broader range than variable types, for example an integer constant will be compatible with an `int` or a `u64` (unsigned 64bit integer) variable as long as its value falls in the range associated with the type. If necessary, a type can be specified with the variable declaration , similar to the variable declarations.

```odin
HOME :: "/users/rob"
VOTING_AGE :: 18
ASCII_A : u8 : 65
```

## Procedures

In Odin procedures can take zero or more parameters (each with a specified type) and can return any number of values (each with a specified type).
Odin is an imperative language and doesn't have methods, all procedures are equivalent to `C` functions.
Values are returned from a procedure using a `return` statement followed by one value for each return value.
If the return values have names, then we can just assign values to them in the procedure and use a naked `return`.
Named values are initialized with their type zero value.
Arguments passed to the procedure during a call are read-only unless they are specified as a pointer.

```odin
// A procedure with two parameters and two return values.
div :: proc(m: int, n: int) -> (quotient: int, remainder: int) {
    quotient = m / n
    remainder = m % n
    return 
}

// A procedure with no return value.
fire_and_forget(what: string) {
  fire(what)
  wipe_memory()
}
```


[application-binary-interface]: https://en.wikipedia.org/wiki/Application_binary_interface

