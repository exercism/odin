#!/usr/bin/env bash

# This script will add description tags to an exercise. This is 
# required for the Test Runner to report test names in plain english.
#
# This is only used for exercises that were checked in without
# descriptions.
#
# The script will overwrite the existing test file.

# Exit script if any subcommands fail
set -eo pipefail

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

get_cache_dir() {
    # find where configlet puts the canonical data
    # ref: https://nim-lang.org/docs/appdirs.html#getCacheDir
    # and: https://stackoverflow.com/q/394230/7552
    if [[ -n "$XDG_CACHE_HOME" && -d "$XDG_CACHE_HOME" ]]; then
        echo "$XDG_CACHE_HOME"
        return
    fi
    case "$OSTYPE" in
        msys* | cygwin*)
            if [[ -n "$LOCALAPPDATA" && -d "$LOCALAPPDATA" ]]; then
                echo "$LOCALAPPDATA"
                return
            fi
            ;;
        darwin*)
            if [[ -e "$HOME/Library/Caches" && -d "$HOME/Library/Caches" ]]; then
                echo "$HOME/Library/Caches"
                return
            fi
            ;;
        *)  # lump all the other *nix systems
            if [[ -e "$HOME/.cache" && -d "$HOME/.cache" ]]; then
                echo "$HOME/.cache"
                return
            fi
            ;;
    esac
    die "Can't find the cache directory that configlet uses"
}


if [[ $# -ne 1 ]]; then
  echo "Usage bin/tag-fixer.sh <path to exercise>"
  exit 1
fi

exercise_path=$1
[[ -d "$exercise_path" ]] || die "$exercise_path doesn't exist"

exercise_slug=$(basename "$exercise_path")
exercise_snake_name=$(to_snake_case <<< "$exercise_slug")

test_file="$exercise_path/${exercise_snake_name}_test.odin"
[[ -f "$test_file" ]] || die "$test_file doesn't exist"

out_file="$exercise_path/updated_${exercise_snake_name}_test.odin"

# tagfixer can use either canonical-data.json or tests.toml, using the 2nd for now.
#metadata_path="$(get_cache_dir)/exercism/configlet/problem-specifications/exercises/$exercise_slug"
#metadata_file="$metadata_path/canonical-data.json"
metadata_path="$exercise_path/.meta"
metadata_file="$metadata_path/tests.toml"

[[ -f "$metadata_file" ]] || die "$metadata_file doesn't exist"

echo -e "Adding description tags to $test_file..."
rm -f "$out_file"
odin run dev/tools/tagfixer -- "$test_file" "$metadata_file" "$out_file"
# There is an extra blank line at the end of out_file, remove it manually for now.
sed -e '$!b' -e '/^\s*$/d' "$out_file" >"$out_file.tr"
mv "$out_file.tr" "$out_file"

# if ! diff "$test_file" "$out_file"; then
#     diff_exit_code=$?
#     if [ $diff_exit_code -gt 1 ]; then
#         echo "Error: can't run diff on $test_file and $out_file (Exit code $diff_exit_code)" >&2
#         exit $diff_exit_code
#     fi
# fi
# mv "$out_file" "$test_file"
# echo ""
# echo "Updated tags written to $test_file"

echo ""
echo "Updated tags written to  :  $out_file"
echo "Check result and move to :  $test_file"
