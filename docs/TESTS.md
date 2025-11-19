# Tests

Odin exercises within your exercism project directory can be run by changing to the exercise directory, and running `odin test .`.

```bash
$ cd "$(exercism workspace)"/odin/leap
$ odin test .
```

## Skipped Tests

`odin test` runs each procedure that has the `@(test)` attribute.

In the test suite, you will notice most of these attributes are commented.
This is to promote [Test Driven Development][tdd]:

- you write just enough code to pass the first test;
- then you uncomment the next test attribute, and write just enough code to pass that test;
- repeat until your code passes all the tests.

## References

For more details, see [The Test Runner][test-runner] documentation, and `odin test -help`.

[tdd]: https://exercism.org/docs/tracks/python/test-driven-development
[test-runner]: https://odin-lang.org/docs/testing/#the-test-runner
