# About

In this concept, we will discuss the minimum you need to write a program in Odin: comments, packages, variables, constants, and procedures.

Odin is a strongly typed language and supports the typical set of types: multiple size integer types (we will use `int` in this concept), floating points, boolean, and strings as well as arrays, records, maps (dictionaries), and pointers.
Odin supports type inference and can infer types from an initial declaration is a value is provided.
These will be discussed in later concepts.

## Comments

Odin uses standard comments from the `C` family.

- Single line comments uses `//`.
- Multi-line comments starts with `/*`, ends with `*/`, and can be nested.
- Documentation comments uses `///` and can be placed before types or procedures definitions.

```odin
// a single line comment.

/*
 * This comment
 * is spread over several lines.
 */
```

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

The `import` statement references the path of the imported package relative to the location of the importing package.
In our example, the Odin files for the `package` `gears` will be located two sub-directory below the lasagna `package`.
The `import cooking/gears` above will make all public objects from `kitchen_gears.odin` and `outdoors_gears.odin` available with when prefixed with `gears.`.

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

If the package belongs to the standard library (`core`), just prefix the package name with `core:` and the compiler will automatically grab the code from the Odin installation.
For example, the standard library `fmt` package can be imported with:

```
import "core:fmt"
```

## Variables

Odin is statically typed and all variables must have a type, however Odin supports type inference avoiding unnecessary redundancy.
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
Constant values are typed but their types have a broader range than variable types, for example an integer constant will be compatible with an `int` or a `u64` (unsigned 64bit integer) variable as long as its value falls in the range associated with the type.
If necessary, a type can be specified with the variable declaration, similar to the variable declarations.

```odin
HOME :: "/users/rob"
VOTING_AGE :: 18
ASCII_A : u8 : 65
```

## Procedures

Odin is purely an imperative language and doesn't support Object Oriented style methods, just procedures (what `C` would call functions).
Procedures can take zero or more parameters (each with a specified type) and can return zero or more values (each with a specified type).

The `return` statement is used to return control to the caller, it is followed by the (comma separated) set of return values (if any).
If the return values have names, they will be treated as (zero value initialized) local variables and you can just treat them as such.
It is idiomatic with named return values to use a naked `return`.

Arguments passed to the procedure during a call are read-only unless their type is specified as a pointer type or there are an implicit reference type (such as slices or maps discussed in later concepts).

Odin doesn't support implicit procedure overloading (no two procedures, in a package, can have the same name). It provides a more limited explicit overloading (to be discussed in a later concept).

```odin
// A procedure with two parameters and two return values.
div :: proc(m: int, n: int) -> (int, int) {
    quotient = m / n
    remainder = m % n
    return quotient, remainder
}

// The same procedure but using named return values.
div :: proc(m: int, n: int) -> (quotient: int, remainder: int) {
    quotient = m / n
    remainder = m % n
    // Naked return that implicitly returns the named return values
    // quotient and remainder.
    return 
}

// A procedure with no return value.
fire_and_forget(what: string) {
  fire(what)
  wipe_memory()
}
```

## Reference Materials

- [Overview: Comments][odin-overview-comments]
- [Overview: Packages][odin-overview-packages]
- [Overview: Constants][odin-overview-constants]
- [Overview: Variables][odin-overview-variables]
- [Introduction: Variables and Constants][odin-introduction-variables-and-constants]

[odin-overview-comments]: https://odin-lang.org/docs/overview/#comments
[odin-overview-packages]: https://odin-lang.org/docs/overview/#packages
[odin-overview-constants]: https://odin-lang.org/docs/overview/#constant-declarations
[odin-overview-variables]: https://odin-lang.org/docs/overview/#variable-declarations
[odin-introduction-variables-and-constants]: https://zylinski.se/posts/introduction-to-odin/#variables-and-constants
