# Odin

<br>

Hi. &nbsp;👋🏽 &nbsp;👋 &nbsp;**We are happy you are here.**&nbsp; 🎉&nbsp;🌟

<br>

**`exercism/odin`** is one of many programming language tracks on [Exercism](exercism-website).
This repo holds all the instructions, tests, code, and support files for Odin _exercises_ currently under development or implemented and available for students.

🌟 &nbsp;&nbsp;Track exercises support the `dev-2024-08` release of Odin.

Exercises are grouped into **concept** exercises which teach the Odin syllabus, which will eventually live [here][odin-syllabus], and **practice** exercises, which are unlocked by progressing in the syllabus tree &nbsp;🌴&nbsp;.
Concept exercises are constrained to a small set of language or syntax features.
Practice exercises are open-ended, and can be used to practice concepts learned, try out new techniques, and _play_. These two exercise groupings can be found in the track [config.json][config-json], and under the `odin/exercises` directory.

<br><br>

<div>
<span>
<img align="left" height="60" width="85" src="https://user-images.githubusercontent.com/5923094/204436863-2ebf34d1-4b16-486b-9e0a-add36f4c09c1.svg">
</span>
<span align="left">

🌟🌟&nbsp; Please take a moment to read our [Code of Conduct][exercism-code-of-conduct]&nbsp;🌟🌟&nbsp;  
It might also be helpful to look at [Being a Good Community Member][being-a-good-community-member] & [The words that we use][the-words-that-we-use].

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Some defined roles in our community: [Contributors][exercism-contributors] **|** [Mentors][exercism-mentors] **|** [Maintainers][exercism-track-maintainers] **|** [Admins][exercism-admins]

</span></div>

<br>
<img align="left" width="95" height="90" src="https://github.com/exercism/website-icons/blob/main/exercises/boutique-suggestions.svg">

Here to suggest a new feature or new exercise?? **Hooray!** &nbsp;🎉 &nbsp;  
We'd love if you did that via our [Exercism Community Forum][exercism-forum] where there is a [dedicated thread][odin-thread] for the new Odin track. 
Please read [Suggesting Exercise Improvements][suggesting-improvements] & [Chesterton's Fence][chestertons-fence].  
_Thoughtful suggestions will likely result in faster & more enthusiastic responses from volunteers._

<br>
<img align="left" width="85" height="80" src="https://github.com/exercism/website-icons/blob/main/exercises/word-search.svg">

✨&nbsp;🦄&nbsp; _**Want to jump directly into Exercism specifications & detail?**_  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Structure][exercism-track-structure] **|** [Tasks][exercism-tasks] **|** [Concepts][exercism-concepts] **|** [Concept Exercises][concept-exercises] **|** [Practice Exercises][practice-exercises] **|** [Presentation][exercise-presentation]  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Writing Style Guide][exercism-writing-style] **|** [Markdown Specification][exercism-markdown-specification] (_✨ version in [contributing][website-contributing-section] on exercism.org_)

<br>
<br>

## Contributing an Exercise
If you are interested in contributing a new exercise, please have a look at [this issue][odin-backlog] to see which exercises are waiting on implementation.
Leave a comment in the issue to notify other contributors which exercise you plan to implement.

The `bin/` subdirectory contains several scripts to help you contribute exercises that will run correctly on Exercism:

- `configlet` is a tool to help track maintainers with the maintenance of their track.
  Fetch it by running the `bin/fetch-configlet` script.
  Run `bin/configlet lint` to verify that the track is properly structured.
- `bin/fetch-ols-odinfmt.sh` will fetch the Odin language server (`ols`) that can assist with verifying Odin code directly in your IDE.
  `odinfmt` is a tool that can format Odin code according to the specification in `odinfmt.json`.
  Please run `odinfmt` before pushing your changes to the repository.
  whenever new code is pushed to the repository.
- `bin/format-all.sh` will run `odinfmt` on all `.odin` files in the repository.
- `bin/run-test.sh` runs the tests for a specific exercise, or for all exercises if no exercise name is provided.
- `bin/verify-exercises` checks the integrity of all exercises, including tests.
  It is used by the build system whenever new code is pushed to the repository.
- `bin/configlet` can be used to generate a new exercise. More details follow below.

### Creating a New Exercise
- Run `bin/configlet create --practice-exercise <slug>` to automatically generate the exercise skeleton in the `exercises/practice/<slug>/` directory and to update `config.json` to reference the new exercise.
  You can add `--author <your_exercism_username>` as option to mark yourself as the creator of this exercise (or add it later in the exercise's `.meta/config.json` file.)
- Add a solution stub at the exercise's `<slug>.odin` file.
  This is what students will begin with when they start the exercise. 
  It should make it as easy as possible to understand what they need to solve, without revealing too much of the solution.
  Stub functions should usually panic, e.g. `#panic("Please implement the <stub> function.")`.
- Add tests to `<slug>_test.odin`.
  Verify that the slug solution would fail _all_ tests.
- Implement a reference solution at `.meta/<slug>_example.odin`.
- Use `bin/run_test.sh <slug>` to verify that your reference solution passes.

[being-a-good-community-member]: https://github.com/exercism/docs/tree/main/community/good-member
[chestertons-fence]: https://github.com/exercism/docs/blob/main/community/good-member/chestertons-fence.md
[concept-exercises]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md
[config-json]: https://github.com/exercism/odin/blob/main/config.json
[exercise-presentation]: https://github.com/exercism/docs/blob/main/building/tracks/presentation.md
[exercism-admins]: https://github.com/exercism/docs/blob/main/community/administrators.md
[exercism-code-of-conduct]: https://exercism.org/docs/using/legal/code-of-conduct
[exercism-concepts]: https://github.com/exercism/docs/blob/main/building/tracks/concepts.md
[exercism-contributors]: https://github.com/exercism/docs/blob/main/community/contributors.md
[exercism-forum]: https://forum.exercism.org/
[exercism-markdown-specification]: https://github.com/exercism/docs/blob/main/building/markdown/markdown.md
[exercism-mentors]: https://github.com/exercism/docs/tree/main/mentoring
[exercism-tasks]: https://exercism.org/docs/building/product/tasks
[exercism-track-maintainers]: https://github.com/exercism/docs/blob/main/community/maintainers.md
[exercism-track-structure]: https://github.com/exercism/docs/tree/main/building/tracks
[exercism-website]: https://exercism.org/
[exercism-writing-style]: https://github.com/exercism/docs/blob/main/building/markdown/style-guide.md
[freeing-maintainers]: https://exercism.org/blog/freeing-our-maintainers
[practice-exercises]: https://github.com/exercism/docs/blob/main/building/tracks/practice-exercises.md
[prs]: https://github.com/exercism/docs/blob/main/community/good-member/pull-requests.md
[odin-backlog]: https://github.com/exercism/odin/issues/26
[odin-release]: https://github.com/odin-lang/Odin/releases/tag/dev-2024-08
[odin-syllabus]: https://exercism.org/tracks/odin/concepts
[odin-thread]: https://forum.exercism.org/t/new-track-odin-programming-language/7379
[suggesting-improvements]: https://github.com/exercism/docs/blob/main/community/good-member/suggesting-exercise-improvements.md
[the-words-that-we-use]: https://github.com/exercism/docs/blob/main/community/good-member/words.md
[website-contributing-section]: https://exercism.org/docs/building
