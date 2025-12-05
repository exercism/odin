#!/usr/bin/env bash

# This script split the overall concept introduction document
# into the about.md and introduction.md for the concept
# and the introduction.md for the concept exercise.
# The convention is that the overall document is located in the
# concept directory and is named `_introduction.md`.
# It is expected that this script will be run from the repo
# top-directory like the other scripts in `bin`.

# Exit script if any subcommands fail
set -eou pipefail

die() {
    echo "$*" >&2
    exit 1
}

to_snake_case() {
    sed -E '
        s/[ -]/_/g
        s/([[:lower:][:digit:]])([[:upper:]])/\1_\2/g
        s/[^[:alnum:]_]//g
    ' | tr '[:upper:]' '[:lower:]'
}

show_help() {
    cat << EOL

This tool takes the overall document for a concept and generates the concept 'about.md',
'introduction.md' files and the concept exercise 'introduction.md'.

Warning: running gen-concept-doc.sh will overwrite the existing versions of these files.

It is expected that the overall concept document is located at
'concepts/<concept-slug>/_introduction.md'.

See 'dev/tools/mkdoc/example.md' for instructions on how to write
the overall concept document.

Usage:
  bin/gen-concept-doc.sh <concept-slug path> <exercise-slug path>

EOL
    exit 1
}

[[ $# -eq 2 ]] || show_help

concept_slug="${1:-}"
concept_path="concepts/${concept_slug}"

exercise_slug="${2:-}"
exercise_path="exercises/concept/${exercise_slug}"

[[ -d "${concept_path}" ]] || die "${concept_path} is not a valid directory"
[[ -d "${exercise_path}" ]] || die "${exercise_path} is not a valid directory"

source_path="${concept_path}/_introduction.md"
about_path="${concept_path}/about.md"
concept_intro_path="${concept_path}/introduction.md"
exercise_intro_path="${exercise_path}/introduction.md"

if odin run dev/tools/mkdoc --  "$source_path" "$about_path" "$concept_intro_path" "$exercise_intro_path"
then
  echo -e "Source   : - ${source_path}"
  echo -e "Generated:"
  echo -e "           - ${about_path}"
  echo -e "           - ${concept_intro_path}"
  echo -e "           - ${exercise_intro_path}"
else
  echo "Error encountered while running mkdoc"
fi