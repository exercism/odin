# Tests

Odin exercises within your exercism project directory can be run by changing to the exercise directory, and running `odin test .`.

```sh
cd "$(exercism workspace)"/odin/leap
odin test .
```

## Enabling Language Checks

While you are testing, Odin can "vet" your code: it can look for things like unused imports and variables.

Run your tests with

```sh
odin test . -vet
```

For even more checks, add the `-strict-style` option.

## Test Driven Development (TDD)

`odin test` runs each procedure that has the `@(test)` attribute.

In the test suite, you will notice each test procedure has this attribute.
This means that when you launch the tests, each test procedure is going to run.

Exercism generally promotes [Test Driven Development][tdd], where:

- initially all tests except the first are configured to be skipped;
- you write just enough code to pass the first test;
- then you enable the next test, and write just enough code to make it pass;
- repeat until your code passes all the tests.

We (the maintainers) did not find an elegant programmatic way to execute a subset of the tests.
The test file just became too unwieldy.
To develop with TDD, you can edit the test file to simply comment out the tests you are not ready to execute, and uncomment them one-by-one as you code your solution.

## References

For more details, see the Odin [Test Runner][test-runner] documentation, and `odin test -help`.

[tdd]: https://exercism.org/docs/using/solving-exercises/tdd
[test-runner]: https://odin-lang.org/docs/testing/#the-test-runner
