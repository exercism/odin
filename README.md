# Odin

Official Exercism forum thread about this track: https://forum.exercism.org/t/new-track-odin-programming-language/7379

Borrowing concepts from other C-based/C-adjacent language tracks:
- https://github.com/exercism/c
- https://github.com/exercism/zig

## Contributing an Exercise
The `bin/` subdirectory contains several scripts to help you contribute exercises that will run
correctly on Exercism:

- `configlet` is a tool to help track maintainers with the maintenance of their track. Fetch it by
  running the `bin/fetch-configlet` script. Run `bin/configlet lint` to verify that the track is
  properly structured.
- `bin/fetch-ols-odinfmt.sh` will fetch the Odin language server (`ols`) that can assist with
  verifying Odin code directly in your IDE. `odinfmt` is a tool that can format Odin code according
  to the specification in `odinfmt.json`. `odinfmt` is automatically invoked by the build system
  whenever new code is pushed to the repository.
- `bin/format-all.sh` will run `odinfmt` on all `.odin` files in the repository.
- `bin/run-test.sh` runs the tests for a specific exercise, or for all exercises if no exercise name is
  provided.
- `bin/verify-exercises` checks the integrity of all exercises, including tests. It is used by the
  build system whenever new code is pushed to the repository.
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
