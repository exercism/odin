# Odin

<br>

Hi. &nbsp;👋🏽 &nbsp;👋 &nbsp;**We are happy you are here.**&nbsp; 🎉&nbsp;🌟

<br>

**`exercism/odin`** is one of many programming language tracks on [Exercism](exercism-website).
This repo holds the instructions, tests, code, and support files for Odin _exercises_ currently under development
or implemented and available for students.

🌟 &nbsp;&nbsp;Track exercises support the `dev-2024-08` release of Odin.

Exercises are grouped into **concept** exercises teaching the Odin syllabus, which will eventually live [here][odin-syllabus], and 
**practice** exercises, which are unlocked by progressing in the syllabus tree &nbsp;🌴&nbsp;.
Concept exercises are constrained to a small set of language or syntax features.
Practice exercises are open-ended, and can be used to practice concepts learned, try out new techniques, and _play_. These two 
exercise groupings can be found in the track [config.json][config-json], and under the `odin/exercises` directory.

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

## Want to contribute an exercise?

If you are interested in contributing a new exercie to the Odin track, it is important to follow the steps below:

- Look at the [Odin Exercise Wishlist][odin-backlog] to see which exercises are waiting on implementation.
- Let the Odin Track Team know that you would like to claim an exercise by posting to the [Odin Thread][odin-thread] on the Exercism Forum.
- If the exercise is still available we will let you know and assign it to you in the [Odin Exercise Wishlist][odin-backlog].
- Once the exercise is assigned to you, you can start working on it.
- When ready to publish, please note that we will accept **only one exercise per Pull Request**. It helps us provide better review and avoid for a lot of work to be tied pending approval because of a problem with a single exercise. You can still claim and work multiple exercises concurrently, just one per PR.
- The Odin track is new, the tooling and documentation is still imperfect and we welcome help in improving it. If you get stuck or need help please let us know by posting to the [Odin Thread][odin-thread] on the Exercism Forum. We will do our best to help you be a successful contributor. If you give it a try and decide, this is not for you, please let us now so that we can put the exercise back into the wishlist.

## Setting up your machine to work on the Exercism Odin track

- You need Odin installed, if you don't have it already, follow the [installation instructions][odin-installation-doc]
- If you have a previous installation of Odin, the language is still evolving and minor syntax difference may cause your program to compile locally but fail when run via the Exercism toolchain. The [installation instructions][odin-installation-doc] contains the version that the Odin track is currently using. We would encourage you to update to that version or at least be aware of the differences.
- If your IDE or text editor supports it, you will benefit from the Odin Language Server and Formatter. They can be found [here][odin-ols-repository]. The [README][odin-ols-readme] contains information on setup for different text editors.
- You need to fork the [Odin Exercism repository][odin-exercism-repository] and clone a copy on your local machine (we will call this local copy `$EXERCISM_ODIN` in the text below).
- On Windows, since all the scripts are setup for bash (`.sh`), I would recommend installing [Git for Windows][git-for-windows] and running the following command from the git bash. This will automatically call your Windows installation of Odin, as long as it is in your path.
- In your local `$EXERCISM_ODIN` repo, run `bin/fetch-configlet.sh`. The `configlet` script is Exercism tools to create and check exercises.
- In your local `$EXERCISM_ODIN` repo, run `bin/fetch-ols-odinfmt.sh`. This will install the Odin formatter for the Odin track tool so this is a different installation than the one you are using for your text editor.

## The Odin track tools

Here is a brief description of the tools you will find in `$EXERCISM_ODIN/bin`:

- `bin/configlet` is the exercism tool. Options that you may use:
  - `lint`: perform a general check on the track exercise and `config.json` file. If an exercise documentation or test description has been updated in the [Problem Specification repository][exercism-problem-specifications], the tool will let you know.
  - `sync`: if `configlet lint` report inconsistencies with the [Problem Specification repository][exercism-problem-specifications], use `bin/configlet sync -u` to fix them.
- `bin/format-all.sh` will run `odinfmt` on all `.odin` files in the repository, using the Odin track approving formatting rules.
- `bin/run-test.sh` runs the tests for a specific exercise, or for all exercises if no exercise name is provided.
- `bin/verify-exercises` checks the integrity of all exercises, including tests. It is used by the build system whenever new code is pushed to the repository.
- `bin/gen-exercise.sh` is used to generate a new exercise. (Don't call `bin/configlet create` directly, `gen-exercise.sh` will take care of it but also includes additional steps).

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
   -  `gen-exercise.sh` attempted to populate the skeleton solution and test file from the problem specification but this tool is lacking right now. If the content of these files, doesn't look right, you can just remove it for now and use your exercise problem specification instead (see below).
-  I would recommend looking at your exercise specification under the [Problem Specification repository][exercism-problem-specifications], under the subdirectory `exercises/<slug name>`, specifically the `canonical-data.json` file. It specifies the test suite your exercise should implement.
-  I would also recommend using this [implemented Odin Exercise][odin-exercise-example] as an example of what each file should contain.
-  When coding, be consistent with the [Odin Style Guide][odin-style-guide]. Future version of the track tooling may enforce its convention.
-  Do not comment out any of the tests. Some Exercism tracks use the convention that only the first test should be un-commented, following a TDD approach. Due to limitations with the tools, the Odin track follows the convention that all tests should be un-commented. You can read the [Odin Test documentation][odin-test-doc] for details.
-  Once you have populated the tests and the example solution, run `bin/run-test.sh exercises/practice/<slug name>` to test your implementation. It should show you that first, your example pass all the tests and second, the student solution stub fails all the tests.
   -  The Odin test running uses a tracking allocator that report memory leaks and dual de-allocations. To be successful, your implementation should ensure there is no memory allocation warnings in addition to failing tests.
   -  If you work with an editor such as VSCode, I would recommend one of two approaches to ensure your IDE is happy:
      -  Approach 1: move your `<slug name>_test.odin` in the `.meta/` directory. This allows the IDE to see both the solution and the test at once. It provides code hints, code references and allow debugging of tests.
      -  When you are done, make sure to move your test file one directory up and to populate `<slug name>.odin` with the data structures and stubs of the procedures to implement.
      -  Approach 2: use the `<slug name>.odin` to implement your solution. The solution and test are in the same directory which will make your IDE happy. Once you are done, you can copy the solution to `.meta/example.odin` and replace the body of the procedures in your student stub (`<slug name>.odin`) with `#panic(Implement this procedure.)`.
-  Once you are happy with your test, you can run:
   -  `bin/format-all.sh` to make sure your test is formatted properly (note: this will also format the other tests which should already be correct. If some changes occur, you can report this to the track maintainers or open an issue on the [Odin repository][odin-repo-issues]).
   -  `bin/verify-exercises` to run all the tests. This is equivalent to `bin/run-test.sh`.
   -  `bin/configlet lint` to check that all the supporting and configuration files are correct.
-  You should now be ready to submit your Pull Request


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
