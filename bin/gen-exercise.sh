#!/usr/bin/env bash

# Note that this is for generating practice exercises only.
# Concept exercises don't have canonical data.

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

show_help() {
    cat << EOL
The tool to generate scaffolding for an exercise.

Usage:
  bin/gen-exercise.sh [options] <exercise slug name>

Options:
  -h                    Display this help text
  -p                    Create a practice exercise (default)
  -c                    Create a concept exercise
  -a                    Specify the (github) author name
  -d                    Specify the difficulty (practice exercise only)
  -b                    Specify the exercise blurb (concept exercise only)
EOL
}

extype=practice
while getopts :hpca:d: opt; do
    case $opt in
        h) show_help; exit ;;
        p) extype=practice ;;
        c) extype=concept ;;
        a) author=$OPTARG ;;
        d) difficulty=$OPTARG ;;
        b) blurb=$OPTARG ;;
        ?) die "unknown option: -$OPTARG" ;;
    esac
done
shift $((OPTIND - 1))

exercise_name="${1:-}"
exercises_path="exercises"
exercise_path="${exercises_path}/${extype}/${exercise_name}"

[[ -n "${exercise_name}" ]] || die "Must give an exercise name to generate"
[[ -d "${exercise_path}" ]] && die "Exercise already exists: ${exercise_name}"

snake_name=${exercise_name//-/_}

# Only practice exercises have problem specifications.
if [[ "$extype" == "practice" ]]; then
  configlet_cache="$(get_cache_dir)/exercism/configlet/problem-specifications/exercises"
  canonical_data_path="${configlet_cache}/${exercise_name}/canonical-data.json"
  if ! [[ -f $canonical_data_path ]]; then
    echo "$exercise_name is not defined in problem-specifications"
    read -rp 'Do you want to continue? [y/N] ' answer
    [[ $answer == y* ]] || exit
  fi
fi

if [[ -z "$author" ]]; then
  read -rp 'What is your github userid? ' author
fi
if [[ "$extype" == "practice" && -z "$difficulty" ]]; then 
  read -rp 'What do you guess the difficulty is? ' difficulty
fi
if [[ "$extype" == "concept" && -z "$blurb"  ]]; then
  read -rp 'What is the exercise blurb? ' blurb
fi

echo "Generating scaffolding for ${type} exercise: ${exercise_name}"

bin/fetch-configlet
if [[ "$extype" == "practice" ]]; then
  bin/configlet create --practice-exercise "${exercise_name}" --author "$author" --difficulty "$difficulty"
elif [[ "$extype" == "concept"  ]]; then
  bin/configlet create --concept-exercise "${exercise_name}" --author "$author"
else
  die "Invalid exercise type: ${type}"
fi

# Concept exercises don't have canonical data
if [[ "$extype" == "practice" ]]; then

  if ! [[ -f $canonical_data_path ]]; then
      canonical_data='{"cases": []}'
  else
      # Some cases reimplement other cases. This jq invocation will filter out the
      # superceded cases.
      canonical_data=$(
          jq '
            def concat($a; $b): if $a == "" then $b else $a + "__" + $b end ;

            def test_cases($description):
                if has("cases") then
                    # this object has nested test cases
                    .description as $d | .cases[] | test_cases(concat($description; $d))
                else
                    # emit this test case with an updated description
                    .description |= concat($description; .)
                end
                ;

            .cases |= (
                reduce (.[] | test_cases("")) as $case ({};
                    $case.reimplements as $r
                    | if $r then del(.[$r]) else . end
                    | .[$case.uuid] = $case
                )
                | [.[]]     # convert an object to a list of values
            )
        ' "$canonical_data_path"
      )
  fi
fi

exercise_config="${exercise_path}/.meta/config.json"

get_from_config() {
    printf "%s/%s" "${exercise_path}" "$(jq --arg type "$1" -r '.files[$type][0]' "$exercise_config")"
}


# The file that the user will edit to create their solution.
# "exercises/practice/hello_world.odin"
solution_file=$(get_from_config 'solution')

if [[ "$extype" == "concept" ]]; then
  example_config_field="exemplar"
else
  example_config_field="example"
fi
# The example solution (for use in tests)
# "exercises/practice/.meta/example.odin"
example_file=$(get_from_config "$example_config_field")

# The test the solution will run against
# "exercises/practice/hello_world_test.odin"
test_file=$(get_from_config 'test')

# TODO: Hacky file generation with bash. Ideally we'd do this with Odin eventually

cat > "${solution_file}" <<EOL
package ${snake_name}
EOL

if [[ "$extype" == "practice" ]]; then

  mapfile -t unique_properties < <(
    jq -r '[.cases[].property] | unique[]' <<< "$canonical_data"
  )

  for unique_property in "${unique_properties[@]}"
  do
    safe_unique_property=$(to_snake_case <<< "${unique_property}")

    cat >> "${solution_file}" <<EOL

${safe_unique_property} :: proc() -> string {
    // Implement this procedure.
    return ""
}
EOL
  done
else
  cat >> "${solution_file}" <<EOL

// Implement solution stub here.
EOL
fi

cat > "${test_file}" <<EOL
package ${snake_name}

import "core:testing"
EOL

if [[ "$extype" == "practice" ]]; then

  canonical_data_length=$( jq '.cases | length' <<< "${canonical_data}" )

  for ((i=0; i < canonical_data_length; i++)); do
    case=$( jq -c ".cases.[$i]" <<< "${canonical_data}" )
    description=$(echo "$case" | jq -r '.description // ""' | to_snake_case)
    property=$(echo "$case" | jq -r '.property // ""' | to_snake_case)
    input=$(echo "$case" | jq -c '.input // ""')
    expected=$(echo "$case" | jq -c '.expected // ""')

    # TODO: Blindly copying input doesn't work most of the time, hence why this generator should be written in Odin itself
    cat >> "${test_file}" <<EOL

@(test)
test_${description} :: proc(t: ^testing.T) {
    input := \`${input}\`
    result := ${property}(input)
    expected := ${expected}

    testing.expect_value(t, result, expected)
}
EOL
  done
else
  cat >> "${test_file}" <<EOL

// Implement tests here.
EOL
fi

# Make the example file a simple copy of the solution file
cp "${solution_file}" "${example_file}"

# Fix the scaffolding generated by configlet for concept exercises.
if [[ "$extype" == "concept" ]]; then

# Concept exercises must have a .docs/hints.md file
  cat > "${exercise_path}/.docs/hints.md" <<EOL
# Hints

## General

- <First General hint>
- ...

## 1. <First task>

- <First hint for first task>
...
EOL

# Blurb must be populated in /meta/config.json
tmp=$(mktemp)
jq '.blurb = "'"$blurb"'"' "${exercise_path}/.meta/config.json" >"$tmp" \
&& mv "$tmp" "${exercise_path}/.meta/config.json"

# Status is required in config.json
tmp=$(mktemp)
jq '.exercises.concept |= map(
  .status //= "wip"
)' config.json >"$tmp" \
&& mv "$tmp" "config.json"

# Need a minimum of text in instructions.md and
# introduction.md so that git doesn't throw them away.
cat >> "${exercise_path}/.docs/introduction.md"<<EOL
# Introduction

The introduction to the exercise goes here.
EOL

cat >> "${exercise_path}/.docs/instructions.md"<<EOL
# Instructions

The instructions for the exercise go here.
EOL
fi

# echo "Formatting new Odin files:"
# bin/odinfmt -w "${exercises_path}"

echo "Be sure to implement the following files:"
echo -e "\t${solution_file}"
echo -e "\t${test_file}"
echo -e "\t${example_file}"
if [[ "$extype" == "concept" ]]; then
  echo -e "\t${exercise_path}/.docs/instructions.md"
  echo -e "\t${exercise_path}/.docs/introduction.md"
  echo -e "\t${exercise_path}/.docs/hints.md"
fi
echo ""

if [[ "$extype" == "practice" ]]; then
  # sort the practice exercises in config.json
  tmp=$(mktemp)
  jq '.exercises.practice |= sort_by(.difficulty, (.name | ascii_upcase))' config.json > "$tmp" \
  && mv "$tmp" config.json
fi

echo "Running configlet lint:"
bin/configlet lint

# Cleaning up temp directories
rm -rf tmp.*

