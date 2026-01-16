# How to Write an Exercise Solution Stub

The goal of the solution stub is to give the student a set of procedures and data structures for them to implement.
Their implementation will then be run against the test suite and report how the number of pass/fail.
They can proceed in a Test-Driven-Development manner until all the tests pass.

It is important that the solution stub we provide compiles.
If it doesn't then, instead of seeing a nice set of test reports, the student will see some (possibly) obscure compilation error.

## Procedure Stubs

For procedures, the strategy we use is to add a comment asking them to implement the procedure body and, if the procedure has any return values, return zero values for the return types.
Here is an example taken out of the High Score exercise.

```odin
scores :: proc(s: High_Scores) -> []int {
	// Implement this procedure.
	return nil
}
```

The zero values in Odin are: `0` for integers and floating-point, `false` for boolean, `""` for string, `nil` for slices, union, and pointers, and an empty literal for struct and arrays.
In doubt, because Odin always initialize variables to their zero value, you can just declare a variable and return it.
Here are a couple of way to return a struct.

```odin
new_scores :: proc(initial_values: []int) -> High_Scores {
	// Implement this procedure.
	return High_Scores{}
}
```

Or if you are not sure what the default value is

```odin
new_scores :: proc(initial_values: []int) -> High_Scores {
	// Implement this procedure.
   result : High_Scores
	return result
}
```

Enumerations representing errors require a slightly different pattern where we do add an `Unimplemented` value and use it as the `zero` value.

## Data Structure

We typically provide the definition of the solution stub procedure input and output types unless they describe the solution internal state or lead towards a specific (non-unique) solution and are either best left to the student to discover.
In our High Score example, the input scores values and the best three scores output are fully defined (`[]int`) but the `High_Scores` `struct` that represents the internal state of the solution is left for them to fill-on:

```odin
// Complete the HighScores data structure.
High_Scores :: struct {}

...

new_scores :: proc(initial_values: []int) -> High_Scores {...}

...

personal_top_three :: proc(s: High_Scores) -> []int {...}
```

## Errors

Errors in Odin are usually defined as enumerations.
We typically provide the full set of Errors as part of the Solution stub.
Having the student trying to guess the error conditions would drive us to provide a solution that doesn't compile making the reported errors confusing.

Here is an example from the `All Your Base` exercise:

```odin
Error :: enum {
	None,
	Invalid_Input_Digit,
	Input_Base_Too_Small,
	Output_Base_Too_Small,
	Unimplemented,
}

rebase :: proc(input_base: int, digits: []int, output_base: int) -> ([]int, Error) {
   	// Please implement the `rebase` procedure.
	return nil, .Unimplemented
}
```

Note the additional `Error` value of `Unimplemented`.
It is only added to provide solution stubs that will fail the tests.

## Stub Procedures May Not Fail all the Tests

It is worth noting that for simple return types (integers or booleans specifically), providing a stub that returns the zero value of the type may not result in all the tests failing and that is perfectly okay.
If we use TDD and write the first implementation of a function returning true, it is bound to pass some tests.
This doesn't mean that the student will not have to work for that specific test and it is likely to fail as soon as he replaces the dummy body with some real logic.
Again, avoiding compile errors and obscure test reports is more valuable than creating a condition where all the tests fail off the bat.
