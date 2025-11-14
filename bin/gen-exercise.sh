#!/usr/bin/env bash

# Note that this is for generating practice exercises only.
# Concept exercises don't have canonical data.

# Exit script if any subcommands fail
set -euo pipefail

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
    [[ -n "$XDG_CACHE_HOME" && -d "$XDG_CACHE_HOME" ]] && return "$XDG_CACHE_HOME"
    case "$OSTYPE" in
        msys* | cygwin*)
            [[ -n "$LOCALAPPDATA" && -d "$LOCALAPPDATA" ]] && return "$LOCALAPPDATA"
            ;;
        darwin*)
            [[ -n "$HOME/Library/Caches" && -d "$HOME/Library/Caches" ]] && return "$HOME/Library/Caches"
            ;;
        *)  # lump all the other *nix systems
            [[ -n "$HOME/.cache" && -d "$HOME/.cache" ]] && return "$HOME/.cache"
            ;;
    esac
    die "Can't find the cache directory that configlet uses"
}

exercise_name="${1:-}"
exercises_path="exercises"
practice_exercises_path="${exercises_path}/practice"
exercise_path="${practice_exercises_path}/${exercise_name}"

[[ -n "${exercise_name}" ]] || die "Must give an exercise name to generate"
[[ -d "${exercise_path}" ]] && die "Exercise already exists: ${exercise_name}"

configlet_cache="$(get_cache_dir)/exercism/configlet/problem-specifications/exercises"
snake_name=${exercise_name//-/_}

canonical_data_path="${configlet_cache}/${exercise_name}/canonical-data.json"
if ! [[ -f $canonical_data_path ]]; then
    echo "$exercise_name is not defined in problem-specifications"
    read -rp 'Do you want to continue? [y/N] ' answer
    [[ $answer == y* ]] || exit
fi

read -rp 'What is your github userid? ' author
read -rp 'What do you guess the difficulty is? ' difficulty

echo "Generating test for exercise: ${exercise_name}"

bin/fetch-configlet
bin/configlet create --practice-exercise "${exercise_name}" --author "$author" --difficulty "$difficulty"

canonical_data='{"cases": []}'
[[ -f $canonical_data_path ]] && canonical_data=$(jq -c . "$canonical_data_path")

exercise_config="${exercise_path}/.meta/config.json"

get_from_config() {
    printf "%s/%s" "${exercise_path}" "$(jq --arg type "$1" -r '.files[$type][0]' "$exercise_config")"
}

# The file that the user will edit to create their solution.
# "exercises/practice/hello_world.odin"
solution_file=$(get_from_config 'solution')

# The example solution (for use in tests)
# "exercises/practice/.meta/example.odin"
example_file=$(get_from_config 'example')

# The test the solution will run against
# "exercises/practice/hello_world_test.odin"
test_file=$(get_from_config 'test')

# TODO: Hacky file generation with bash. Ideally we'd do this with Odin eventually

cat > "${solution_file}" <<EOL
package ${snake_name}

EOL

mapfile -t unique_properties < <(
    jq -r '[.cases[].property] | unique[]' <<< "$canonical_data"
)

for unique_property in "${unique_properties[@]}"
do
    safe_unique_property=$(to_snake_case <<< "${unique_property}")

    cat >> "${solution_file}" <<EOL
${safe_unique_property} :: proc() -> string {
    #panic("Please implement the `${safe_unique_property}` procedure.")
}

EOL
done

cat > "${test_file}" <<EOL
package ${snake_name}

import "core:testing"

EOL

canonical_data_length=$(echo "${canonical_data}" | jq '.cases | length')
for ((i=0; i < canonical_data_length; i++)); do
    case=$(echo "$canonical_data" | jq -c ".cases[$i]")
    description=$(echo "$case" | jq -r '.description // ""' | to_snake_case)
    property=$(echo "$case" | jq -r '.property // ""' | to_snake_case)
    input=$(echo "$case" | jq -c '.input // ""')
    expected=$(echo "$case" | jq -c '.expected // ""')

    # TODO: Blindly copying input doesn't work most of the time, hence why this generator should be written in Odin itself
    cat >> "${test_file}" <<EOL
@(test)
test_${description} :: proc(t: ^testing.T) {
expected := ${expected}
input := \`${input}\`
result := ${property}(input)

testing.expect_value(t, result, expected)
}

EOL
done

# Make the example file a simple copy of the solution file
cp "${solution_file}" "${example_file}"

# echo "Formatting new Odin files:"
# bin/odinfmt -w "${exercises_path}"

echo "Be sure to implement the following files:"
echo -e "\t${solution_file}"
echo -e "\t${test_file}"
echo -e "\t${example_file}"
echo ""

echo "Running configlet lint:"
bin/configlet lint
