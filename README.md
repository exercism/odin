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

## Pre-launch Checklist
Here is a list of practice exercises that we aim to implement before the Odin track goes live on Exercism:

- ~~Hello World~~
- ~~Leap~~
- ~~Difference of Squares~~
- ~~Grains~~
- Resistor Color
- Collatz Conjecture
- Queen Attack
- Darts
- Resistor Color Duo
- Hamming
- Space Age
- RNA Transcription
- Binary
- Eliud's Eggs
- Two Fer
- Raindrops
- D&D Character
- Perfect Numbers
- High Scores
- Pangram
- Resistor Color Trio
- Armstrong Numbers

Other exercises are welcome too!
It is recommended that a track has 20 exercises or more (not counting "Hello World") to go live.

## Contributing an Exercise
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
- `bin/gen-exercise.sh` can be used to generate a new exercise. More details follow below.

### Creating a New Exercise
1. Edit `config.json` to include the information about the new exercise. Add a new entry into the
   `exercises` dictionary, either under `concept` or `practice`. You'll need the unique identifier
   (`uuid`) which is best lifted from another track. This can also be used to populate the slug,
   name, difficulty, and other fields that should typically be similar between tracks.
2. Run `bin/gen-exercise.sh <slug>` to automatically generate the exercise skeleton in the
   `exercises/practice/<slug>/` directory.
3. Edit `exercises/practice/<slug>/.meta/config.json` and populate the `files.solution`,
   `files.test`, and `files.example` arrays to point to the generated files. Add your Exercism
   username to the `authors` array.
4. `exercises/practice/<slug>/<slug>_test.odin` will already contain stubs for a minimum number of
   standard tests for the exercise, but will likely need editing to invoke the right function in the
   solution, and to correctly test the output. It is strongly recommended that you look at the tests
   from a reference track (e.g. C or Zig) and include a more thorough set of tests.

## TODO
- Let `bin/gen-exercise.sh` automatically configure `.meta/config.json` when a new exercise skeleton
  is generated.
- Figure out how to build an Odin test runner (currently using bash script for this)
- [Highlight.js support for Odin](https://github.com/highlightjs/highlight.js/blob/main/SUPPORTED_LANGUAGES.md)

## Odin Docs

- [Odin website](http://odin-lang.org)
- [Odin GitHub](https://github.com/odin-lang/Odin)
- [Odin examples](https://github.com/odin-lang/examples)
- [Odin language server](https://github.com/DanielGavin/ols)

## Exercism Docs

- https://exercism.org/docs/building/tracks/new/request-new
- https://exercism.org/docs/building/tracks/new/add-first-exercise
- https://exercism.org/docs/building/tracks/new/add-initial-exercises
- https://exercism.org/docs/building/tracks/new/setup-continuous-integration
- https://exercism.org/docs/building/tooling/test-runners
- https://github.com/exercism/generic-track
- https://github.com/exercism/problem-specifications

## Example Nix Config

```nix
{ pkgs }:
let
  inherit (pkgs) lib;

  # TODO: Building odinfmt requires the nighly build of Odin itself
  new_pkgs = import
    (pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "ef66aec42b5f9035a675496e9a7fe57b63505646";
      # sha256 = lib.fakeSha256;
      sha256 = "1j1ywwk1wzcd60dbam3pif8z0v695ssmm8g4aw9j01wl36pds31a";
    })
    { };

  odin = new_pkgs.odin;
in
{
  deps = [
    odin
    pkgs.ruby
    pkgs.gh
    pkgs.just
    pkgs.jq
  ];
}
```

*Below is the previous generic track readme; will modify later.*

---

# Exercism Odin Track

[![Configlet](https://github.com/exercism/odin/actions/workflows/configlet.yml/badge.svg)](https://github.com/exercism/odin/actions/workflows/configlet.yml) [![.github/workflows/test.yml](https://github.com/exercism/odin/actions/workflows/test.yml/badge.svg)](https://github.com/exercism/odin/actions/workflows/test.yml)

Exercism exercises in Odin.

## Testing

To test the exercises, run `./bin/test`.
This command will iterate over all exercises and check to see if their exemplar/example implementation passes all the tests.

### Track linting

[`configlet`](https://exercism.org/docs/building/configlet) is an Exercism-wide tool for working with tracks. You can download it by running:

```shell
./bin/fetch-configlet
```

Run its [`lint` command](https://exercism.org/docs/building/configlet/lint) to verify if all exercises have all the necessary files and if config files are correct:

```shell
$ ./bin/configlet lint

The lint command is under development.
Please re-run this command regularly to see if your track passes the latest linting rules.

Basic linting finished successfully:
- config.json exists and is valid JSON
- config.json has these valid fields:
    language, slug, active, blurb, version, status, online_editor, key_features, tags
- Every concept has the required .md files
- Every concept has a valid links.json file
- Every concept has a valid .meta/config.json file
- Every concept exercise has the required .md files
- Every concept exercise has a valid .meta/config.json file
- Every practice exercise has the required .md files
- Every practice exercise has a valid .meta/config.json file
- Required track docs are present
- Required shared exercise docs are present
```

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
[odin-release]: https://github.com/odin-lang/Odin/releases/tag/dev-2024-08
[odin-syllabus]: https://exercism.org/tracks/odin/concepts
[odin-thread]: https://forum.exercism.org/t/new-track-odin-programming-language/7379
[suggesting-improvements]: https://github.com/exercism/docs/blob/main/community/good-member/suggesting-exercise-improvements.md
[the-words-that-we-use]: https://github.com/exercism/docs/blob/main/community/good-member/words.md
[website-contributing-section]: https://exercism.org/docs/building
