# How to Create a New Exercise

Note: in the text below, `$EXERCISM_ODIN` refers to your local copy of the Exercism Odin repository, see [How to Setup your Machine to Contribute to the track][how-to-setup-your-machine-to-contribute-to-the-track] for details.

To create a new exercise, follow the steps below:

Find the `<slug name>` associated with your exercise. The `<slug-name>` is the exercise name with all lowercase and spaces replaced with dashes (Ex: `Circular Buffer` slug name is `circular-buffer`).

Run `bin/gen-exercise.sh <slug-name>`.
This will ask for your github id and an exercise difficulty.
For exercise difficulty, use 2 for easy, 5 for medium, and 9 for hard.
Don't sweat it too much, maintainers will help you adjust the difficulty during the PR review.
This will add an entry in `$EXERCISM_ODIN/config.json` file for your exercise and add a directory under `$EXERCISM_ODIN/exercises/practice/<slug name>` with the exercise files.

Under `$EXERCISM_ODIN/exercises/practice/<slug name>`, edit the following files:
- `<slug name>.odin` contains the skeleton solution file provided to the student (exercise procedures with a dummy body and data structure required to solve the exercise).
- `<slug name>_test.odin` contains the exercise test suite.
- `.meta/example.odin` contains your example solution (should pass all the tests).

Note: `gen-exercise.sh` doesn't always do a good job generating the test and solution stubs.
If the content of these files, doesn't look right, you can just delete it and use your exercise problem specification instead.
The exercise specification is located under the [Problem Specification repository][exercism-problem-specification-repository], in `exercises/<slug name>/canonical-data.json` and specifies the test suite your exercise should implement.
I would also recommend using the [Two Bucket exercise][two-bucket-exercise] as an example for what each file should look like.

The purpose of the example solution is to prove that the problem can be solved.
It doesn't necessarily have to be the most efficient or idiomatic code.

When coding, be consistent with the [Odin Style Guide][odin-style-guide].
The track tooling enforces its convention.

Do not comment out any of the tests directives `@(test)`.
Some Exercism tracks, following a TDD approach, use the convention that only the first test should be un-commented.
Due to limitations with the tools, the Odin track follows the convention that all tests should be un-commented.
You can read the [Odin Test documentation][odin-test-documentation] for details.

Once you have populated the tests and the example solution, run `bin/run-test.sh exercises/practice/<slug name>` to test your implementation.
It verifies that your example passes all the tests and that the solution stub provided to the student fails some the tests.
Because the solution stub returns Odin zero values, it is still possible that some of the solution stub tests pass by default but this will change once the student starts implementing the solution.

The Odin test runner uses a tracking allocator that reports memory leaks and dual de-allocations. To be successful, your implementation should ensure there is no memory allocation warnings in addition to failing tests.
When checking if the student solution passes the tests, we ignore memory leaks in the Exercism UI but they will be pointed out if the student uses a local development environment.

If you work with an editor such as `VSCode`, we recommend one of two approaches to ensure your IDE is happy:

- Approach 1: move your `<slug name>_test.odin` in the `.meta/` directory.
This allows the IDE to see both the solution and the test at once.
It allows code hints, code references and even debugging.
When you are done, make sure to move your test file one directory up and populate `<slug name>.odin` with the data structures and stubs of the procedures to implement.
- Approach 2: use the `<slug name>.odin` to implement your solution. 
The solution and test are in the same directory which will make your IDE happy.
Once you are done, copy the solution to `.meta/example.odin` and replace the body of the procedures in your student stub (`<slug name>.odin`).

**IMPORTANT**: Before you submit your Pull Request, run `bin/check-exercise.sh exercises/practice/<exercise-slug>` and correct any finding.
Remember that **a Pull Request should contain a single exercise** (this facilitates the review and get your exercise merged faster).

You should now be ready to submit your Pull Request

[exercism-problem-specification-repository]: https://github.com/exercism/problem-specifications/tree/main/exercises
[two-bucket-exercise]: https://github.com/exercism/odin/tree/main/exercises/practice/two-bucket
[odin-style-guide]: https://github.com/odin-lang/examples/wiki/Naming-and-style-convention
[odin-test-documentation]: https://github.com/exercism/odin/blob/main/docs/TESTS.md
[how-to-setup-your-machine-to-contribute-to-the-track]: https://github.com/exercism/odin/blob/main/dev/docs/faq
