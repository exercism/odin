# Track Developers - Frequently Asked Questions

This document captures decisions and rationales about how the Odin Exercism track exercises and documentation should be written.

If, after reading the document, you have questions or suggestions, please see if there is already an open [issue](https://github.com/exercism/odin/issues) or post a question to the [Exercism forum](https://forum.exercism.org/c/support/8).

## Why only one exercise per Pull Request?

If you submit a Pull Request with more than one exercise, we will reject it and ask you to split it up.
Why are we doing this? 

- It makes the reviewer job more manageable (smaller amount of code to review) and increase the chance we will give your code a good look.
- Required changes on one exercise will not cause other exercises to be stuck in limbo.
- You get more reputation points this way.
- You can work on multiple exercises in parallel (just keep each exercise in its separate branch)
  
## When Writing Tests, How Do I Compare Result vs. Expected for Slices?

When writing tests, the Odin framework provides useful procedures like `testing.expect()` for boolean values or `testing.expect_value()` for any kind of values that are comparable.
Unfortunately, if you want to compare slices, you will get an error stating that `type_is_comparable(T)` evaluates to false.

There are multiple ways to compare slices, including `slice.equal()` but they don't provide good error messages to the student.
The method that you should use is as follow:

1. Copy this helper function into your test file:

```odin
expect_slices_match :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {
	result := fmt.aprintf("%v", actual)
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str, loc = loc)
}
```

2. use the helper function to compare the result and expected values.

```odin
expect_slices_match(t, result, []int{1, 2, 3, 4, 5})
```

Why are we asking you to use that specific procedure?

If the test fails, the student (especially in the Exercism UI) is shown the test error message.
Using the function above, the message looks like:

```
[forth_test.odin:24:test_parsing_and_numbers__numbers_just_get_pushed_onto_the_stack()] expected result to be [1, 2, 3, 4], got [1, 2, 3, 4, 5]
```

Notice how informative the messages is?
It shows both result and expected values in a human-readable form (while using `slice.equal()` would result in 'expected true, got false'). In addition it correctly identify the line where the test fails (not the line in the helper procedure) and properly identify the result as 'result'.
There are other ways to achieve the same result but this one is already tested.

## How to Integrate Benchmarks in Odin Practice Exercises?

If you are developing an exercise and you want to add benchmark code, you **must** follow the guidance below.

Benchmark are really intended for students running the exercise locally and not through the Exercism UI, therefore the test attribute for the benchmark code **should be commented out** when you submit the exercise Pull Request.
In addition, you should place a header explaining to the student that this benchmark is optional and they can un-comment the attribute if they want to work the performance angle.

```odin
// Optional Benchmarking Code
// If you are using Exercism CLI Interface and want to test
// the performance of your solution, un-comment the following
// test attribute.

// @(test)
benchmark_pascals_triangle :: proc(t: ^testing.T) {
    ...
}
```

The Odin `core:time` package provides a `benchmark()` method that can provide timing information on the exercise procedures. You can see how to set it up in the [Pascal Triangle Tests](../../exercises/practice/pascals-triangle/pascals_triangle_test.odin).

The Test Runner has strict limits (CPU and time) and is not a good environment for benchmarking.
Adding un-commented benchmark code to the tests may cause the Test Runner to time out (if you are running through the Exercism UI) frustrating students who have a correct solution. 

## How Do I Develop Documentation for a Concept?

A Concept requires two documents:

- The `introduction.md` document provides an introduction to the concept and is shown to the student before it solves the concept exercise.
- The `about.md` provides a more complete introduction and replaces the `introduction.md` once the student has solved the exercise.

The about documentation is, typically, a more detailed version of the introduction document and will contain links to online docs, articles and other relevant information.

In addition, each Odin concept has a single associated concept exercise designed to illustrate the concept. This exercise also requires an introduction document to introduce the concept in the context of the exercise.
Typically, it is  either the same as the concept introduction or a cut-down version focusing on solving the exercise.

To avoid these three documents being inconsistent, the concept developer should produce a single document with tags indicating which sections goes in which of the three documents (a section could be common to all the documents, specific to one, or anywhere in between).

The document should be located at `concepts/<concept-slug>/_introduction.md`.
The tags to associate sections to documents are described in this [example file](../tools/mkdoc/example.md) and the tool used to generate all the documents from this single one is `bin/gen-concept-docs.sh`.





