# When Writing Tests, How To Compare Result vs. Expected for Slices?

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

Note how informative the messages is?
It shows both result and expected values in a human-readable form (while using `slice.equal()` would result in 'expected true, got false').
In addition it correctly identifies the line where the test fails (not the line of the `expect_value()` in the helper procedure) and properly identify the result as 'result'.
There are other ways to achieve the same result but this one is battle tested.
