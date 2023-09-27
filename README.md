# Odin

Official Exercism forum thread about this track: https://forum.exercism.org/t/new-track-odin-programming-language/7379

Borring concepts from other C-based/C-adjacent language tracks:
- https://github.com/exercism/c
- https://github.com/exercism/zig

## TODO

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

*Below is the previous `generic-track` readme; will delete later.*

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
