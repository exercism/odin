## How to contribute an exercise?

If you are interested in contributing a new exercise to the Odin track, it is important to follow the steps below:

- Look at the [Odin Exercise Wishlist][odin-backlog] to see which exercises are waiting on implementation.
- Let the Odin Track Team know that you would like to claim an exercise by posting to the [Odin Thread][odin-thread] on the Exercism Forum.
- If the exercise is still available we will let you know and assign it to you in the [Odin Exercise Wishlist][odin-backlog].
- Once the exercise is assigned to you, you can start working on it.
- When ready to publish, please note that we will accept **only one exercise per Pull Request**. It helps us provide better review and avoid having exercises that are ready to be merged tied in PRs because of a problem with a single exercise. You can still claim and work multiple exercises concurrently, just one per PR.
- The Odin track is new, the tooling and documentation is still imperfect and we welcome help in improving it. If you get stuck or need help please let us know by posting to the [Odin Thread][odin-thread] on the Exercism Forum. We will do our best to help you be a successful contributor. If you give it a try and decide, this is not for you, please let us now so that we can put the exercise back into the wishlist.

## Setting up your machine to work on the Exercism Odin track

- You need Odin installed, if you don't have it already, follow the [installation instructions][odin-installation-doc]
- If you have a previous installation of Odin, the language is still evolving and minor syntax difference may cause your program to compile locally but fail when run via the Exercism toolchain.
   The [installation instructions][odin-installation-doc] contains the version that the Odin track is currently using.
   We encourage you to update to that version or at least be aware of the differences.
- If your IDE or text editor supports it, you will benefit from the Odin Language Server and Formatter.
   They can be found [here][odin-ols-repository].
   The [README][odin-ols-readme] contains information on setup for different text editors.
- You need to fork the [Odin Exercism repository][odin-exercism-repository] and clone a copy on your local machine (we will call this local copy `$EXERCISM_ODIN` in the text below).
- On Windows, since all the scripts are setup for bash (`.sh`), I would recommend installing [Git for Windows][git-for-windows] and running the following command from the git bash.
   This will automatically call your Windows installation of Odin, as long as it is in your path.
- In your local `$EXERCISM_ODIN` repo, run `bin/fetch-configlet.sh`.
   The `configlet` script is Exercism tools to create and check exercises.
- In your local `$EXERCISM_ODIN` repo, run `bin/fetch-ols-odinfmt.sh`.
   This will install the Odin formatter for the Odin track tool so this is a different installation than the one you are using for your text editor.

## The Odin track tools

Here is a brief description of the tools you will find in `$EXERCISM_ODIN/bin`:

- `bin/configlet` is the exercism tool. Options that you may use:
  - `lint`: perform a general check on the track exercise and `config.json` file.
   If an exercise documentation or test description has been updated in the [Problem Specification repository][exercism-problem-specifications], the tool will let you know.
  - `sync`: if `configlet lint` report inconsistencies with the [Problem Specification repository][exercism-problem-specifications], use `bin/configlet sync -u` to fix them.
- `bin/format-all.sh` will run `odinfmt` on all `.odin` files in the repository, using the Odin track approving formatting rules.
- `bin/run-test.sh` runs the tests for a specific exercise, or for all exercises if no exercise name is provided.
- `bin/verify-exercises` checks the integrity of all exercises, including tests. It is used by the build system whenever new code is pushed to the repository.
- `bin/gen-exercise.sh` is used to generate a new exercise. (Don't call `bin/configlet create` directly, `gen-exercise.sh` will take care of it but also includes additional steps).
- `bin/check-exercise.sh` checks that your exercise is ready for a Pull Request, it will check most of the same details than PR reviewers do (minus the logic and naming) and will make the process smoother.

### Creating a New Exercise

To create a new exercise, follow the steps below:

- Find the `<slug name>` associated with your exercise. The `<slug-name>` is the exercise name with all lowercase and spaces replaced with dashes (Ex: Circular Buffer slug name is circular-buffer)
- run `bin/gen-exercise.sh <slug-name>`
  - This will ask for your github id and an exercise difficulty
  - For exercise difficulty, use 2 for easy, 5 for medium, and 9 for hard. Don't sweat it too much, maintainers will help you during the PR review.
  - This will add an entry in `$EXERCISM_ODIN/config.json` file for your exercise and add a directory under `$EXERCISM_ODIN/exercises/practice/<slug name>` with the exercise files.
-  Under `$EXERCISM_ODIN/exercises/practice/<slug name>`, edit the following files:
   -  `<slug name>.odin` will contain the skeleton solution file provided to the student. It should only include data structures and exercise procedures to implement with a dummy body.
   -  `<slug name>_test.odin` will contain your test suite.
   -  `.meta/example.odin` will contain your example solution (should pass all the tests).
- Note:  `gen-exercise.sh` doesn't always do a good job generating the test and solution stubs.
   If the content of these files, doesn't look right, you can just delete it and use your exercise problem specification instead.
   The exercise specification is located under the [Problem Specification repository][exercism-problem-specifications], in `exercises/<slug name>/canonical-data.json` and specifies the test suite your exercise should implement.
-  I would also recommend using this [implemented Odin Exercise][odin-exercise-example] as an example for what each file should look like.
- The purpose of the example solution is to prove that the problem can be solved.
   It doesn't necessarily have to be the most efficient or idiomatic code.
   Reviewer may still recommend changes but there are multiple path to solving an exercise.
-  When coding, be consistent with the [Odin Style Guide][odin-style-guide].
   Future version of the track tooling may enforce its convention.
-  Do not comment out any of the tests directives ()`@(test)`). Some Exercism tracks use the convention that only the first test should be un-commented, following a TDD approach. Due to limitations with the tools, the Odin track follows the convention that all tests should be un-commented. You can read the [Odin Test documentation][odin-test-doc] for details.
-  Once you have populated the tests and the example solution, run `bin/run-test.sh exercises/practice/<slug name>` to test your implementation. It should show you that first, your example pass all the tests and second, the student solution stub fails all the tests.
   -  The Odin test running uses a tracking allocator that report memory leaks and dual de-allocations. To be successful, your implementation should ensure there is no memory allocation warnings in addition to failing tests.
   -  If you work with an editor such as VSCode, I would recommend one of two approaches to ensure your IDE is happy:
      -  Approach 1: move your `<slug name>_test.odin` in the `.meta/` directory.
         This allows the IDE to see both the solution and the test at once.
         It provides code hints, code references and allow debugging of tests.
         When you are done, make sure to move your test file one directory up and populate `<slug name>.odin` with the data structures and stubs of the procedures to implement.
      -  Approach 2: use the `<slug name>.odin` to implement your solution.
         The solution and test are in the same directory which will make your IDE happy.
         Once you are done, you can copy the solution to `.meta/example.odin` and replace the body of the procedures in your student stub (`<slug name>.odin`).
-  IMPORTANT: Before you submit your Pull Request
   -  Run `bin/check-exercise.sh exercises/practice/<exercise-slug>` and correct any finding
   -  Remember that a Pull Request should contain a single exercise (this facilitates the review and get your exercise merged in the track faster)
-  You should now be ready to submit your Pull Request

### How to Write a Solution Stub?

The goal of the solution stub is to give the student a set of procedures and data structures for them to implement.
Their implementation will then be run against the test suite and report how the number of pass/fail.
They can proceed in a Test-Driven-Development manner until all the tests pass.

It is important that the solution stub we provide compiles. If it doesn't then instead of seeing a nice set of test reports, the student will see some (possibly) obscure compilation error.

### Procedure Stubs

For procedures, the strategy we use is to add a comment asking them to implement the procedure body and, if the procedure has any return values, return zero values for the return types. Here is an example taken out of the High Score exercise.

```odin
scores :: proc(s: High_Scores) -> []int {
	// Implement this procedure.
	return nil
}
```

The zero values in Odin are: `0` for integers and floating-point, `false` for boolean, `""` for string, `nil` for slices, `union`, and pointers, and an empty literal for `struct` and arrays.
In doubt, because Odin always initialize variables to their zero value, you can just declare a variable and return it. Here are a couple of way to return a `struct`.

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

One pattern that is a little bit different is for `enum` representing errors where you can add an `Unimplemented` value and return it in the stub procedure.

### Data Structure

We typically provide the definition of the solution stub procedure input and output unless they describe the solution internal state and are either best left to the student to discover as part of the solution or because defining the structure would drive towards a particular solution.
In our High Score example, the input scores values and the output three best are fully defined (`[]int`) but the `High_Scores` `struct` that represents the internal state of the solution is left for them to fill-on:

```odin
// Complete the HighScores data structure.
High_Scores :: struct {}

...

new_scores :: proc(initial_values: []int) -> High_Scores {...}

...

personal_top_three :: proc(s: High_Scores) -> []int {...}
```

### Errors

Errors in Odin are usually defined as enumerations. We typically provide the full set of Errors as part of the Solution stub.
Having the student trying to guess the error conditions would drive us to provide a solution that doesn't compile and would not increase the challenge of solving the exercise.

Here is an example from the All Your Base exercise:

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

Note the additional Error value of Unimplemented. It is only added to provide solution stubs that will fail the tests.

### Stub Procedures May Not Fail all the Tests

It is worth noting that for simple return types (integers or booleans specifically), providing a stub that returns the zero value of the type may not result in all the tests failing and that is perfectly okay.
If I perform TDD at home and write the first implementation of a function returning true, it is bound to pass some tests.
This doesn't mean that the student will not have to work for that specific test and it is likely to fail as soon as he replaces the dummy body with some real logic.
Again, this is more valuable than creating a condition where they are faced with a compilation error right off the bat.


[being-a-good-community-member]: https://github.com/exercism/docs/tree/main/community/good-member
[chestertons-fence]: https://github.com/exercism/docs/blob/main/community/good-member/chestertons-fence.md
[concept-exercises]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md
[config-json]: https://github.com/exercism/odin/blob/main/config.json
[exercism-admins]: https://github.com/exercism/docs/blob/main/community/administrators.md
[exercism-code-of-conduct]: https://exercism.org/docs/using/legal/code-of-conduct
[exercism-concepts]: https://github.com/exercism/docs/blob/main/building/tracks/concepts.md
[exercism-contributors]: https://github.com/exercism/docs/blob/main/community/contributors.md
[exercism-forum]: https://forum.exercism.org/
[exercism-markdown-specification]: https://github.com/exercism/docs/blob/main/building/markdown/markdown.md
[exercism-mentors]: https://github.com/exercism/docs/tree/main/mentoring
[exercise-presentation]: https://github.com/exercism/docs/blob/main/building/tracks/presentation.md
[exercism-problem-specifications]: https://github.com/exercism/problem-specifications/
[exercism-tasks]: https://exercism.org/docs/building/product/tasks
[exercism-track-maintainers]: https://github.com/exercism/docs/blob/main/community/maintainers.md
[exercism-track-structure]: https://github.com/exercism/docs/tree/main/building/tracks
[exercism-website]: https://exercism.org/
[exercism-writing-style]: https://github.com/exercism/docs/blob/main/building/markdown/style-guide.md
[freeing-maintainers]: https://exercism.org/blog/freeing-our-maintainers
[git-for-windows]: https://gitforwindows.org/
[odin-backlog]: https://github.com/exercism/odin/issues/53
[odin-exercise-example]: https://github.com/exercism/odin/tree/main/exercises/practice/two-bucket
[odin-exercism-repository]: https://github.com/exercism/odin
[odin-installation-doc]: https://github.com/exercism/odin/blob/main/docs/INSTALLATION.md
[odin-ols-readme]: https://github.com/DanielGavin/ols/blob/master/README.md
[odin-ols-repository]: https://github.com/DanielGavin/ols
[odin-release]: https://github.com/odin-lang/Odin/releases/tag/dev-2024-08
[odin-repo-issues]: https://github.com/exercism/odin/issues
[odin-style-guide]: https://github.com/odin-lang/examples/wiki/Naming-and-style-convention
[odin-syllabus]: https://exercism.org/tracks/odin/concepts
[odin-test-doc]: https://github.com/exercism/odin/blob/main/docs/TESTS.md
[odin-thread]: https://forum.exercism.org/t/new-track-odin-programming-language/7379
[prs]: https://github.com/exercism/docs/blob/main/community/good-member/pull-requests.md
[practice-exercises]: https://github.com/exercism/docs/blob/main/building/tracks/practice-exercises.md
[suggesting-improvements]: https://github.com/exercism/docs/blob/main/community/good-member/suggesting-exercise-improvements.md
[the-words-that-we-use]: https://github.com/exercism/docs/blob/main/community/good-member/words.md
[website-contributing-section]: https://exercism.org/docs/building
