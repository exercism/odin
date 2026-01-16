# The Odin Track Tools

Note: in the text below, `$EXERCISM_ODIN` refers to the directory of your local copy of the Exercism Odin repository, see [How to Setup your Machine to Contribute to the track][how-to-setup-your-machine-to-contribute-to-the-track] for details.

Here is a brief description of the tools you will find in `$EXERCISM_ODIN/bin`:

- `bin/configlet` is the official Exercism track maintenance tool, its options include:
  - `lint`: perform a general check on the track exercise and config.json file, it will flag updates to the exercise documentation or test description in the [Problem Specification repository][exercism-problem-specification-repository]
  - `sync`: if `configlet lint` reports inconsistencies with the [Problem Specification repository][exercism-problem-specification-repository], run `bin/configlet sync -u` to fix them.
- `bin/format-all.sh` will run `odinfmt` on all `.odin` files in the repository, using the Odin track approved formatting rules.
- `bin/run-test.sh` runs the tests for a specific exercise, or for all exercises if no exercise name is provided.
- `bin/verify-exercises` checks the integrity of all exercises, including tests (used by the build system whenever new code is pushed to the repository).
- `bin/gen-exercise.sh` is used to generate a new exercise. (Don't call `bin/configlet create` directly, `gen-exercise.sh` takes care of it but also includes extra steps).
- `bin/check-exercise.sh` checks that your exercise is ready for a Pull Request, it will check most of the same details than PR reviewers do (minus the logic and naming) and will make the process smoother.

[exercism-problem-specification-repository]: https://github.com/exercism/problem-specifications/tree/main/exercises
[how-to-setup-your-machine-to-contribute-to-the-track]: https://github.com/exercism/odin/blob/main/dev/docs/faq
