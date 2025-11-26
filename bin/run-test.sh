#!/usr/bin/env bash

usage() {
    echo "Usage: $0 [path/to/exercise]" >&2
    exit 1
}

# Exit script if any subcommands fail
set -euo pipefail

cd "$(realpath "$(dirname "$0")/..")"

# Delete the temp directory
function cleanup {
    [[ -v tmp_path ]] && rm -rf "${tmp_path}"
}
# Register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

get_from_config() {
    jq --arg type "$1" --arg path "${exercise_path}" -r '
        .files[$type] // [] | map([$path, .] | join("/"))[]
    ' "$config"
}

run_test() {
    local exercise_path="${1:-}"    # due to `set -u`, provide a default value

    if [[ -z "${exercise_path}" ]]; then
        echo "Running all tests"
        shopt -s nullglob
        for exercise in exercises/{practice,concept}/*/; do
            run_test "$exercise"
        done
        return
    fi

    ## test one exercise
    local exercise_name
    exercise_name=$(basename "${exercise_path}")
    echo "Running test for exercise: ${exercise_name}"

    if ! [[ -d "${exercise_path}" ]]; then
        echo "no such exercise directory: ${exercise_name}" >&2
        usage
    fi

    local config="${exercise_path}/.meta/config.json"
    local -A files
    for type in 'solution' 'example' 'test' 'editor'; do
        files[$type]=$(get_from_config $type)
    done

    local snake_name=${exercise_name//-/_}
    local -g tmp_path   # the cleanup function needs a global variable
    tmp_path=$(mktemp -d)

    echo
    echo "$exercise_name / $exercise_path"

    # Copy the source files into the temporary directory
    cp "${files[example]}" "${tmp_path}/${snake_name}.odin"
    cp "${files[test]}" "${tmp_path}"
    # shellcheck disable=SC2086
    [[ -n ${files[editor]} ]] && (set -f; cp -t "${tmp_path}" ${files[editor]})

    # Run the tests using the example file to verify that it is a valid solution.
    # Turn off `-e`, we don't want to abort if there's a non-zero status.
    local result status
    set +e
    result=$( odin test "${tmp_path}" -vet -strict-style -vet-tabs -disallow-do -warnings-as-errors 2>&1 )
    status=$?
    set -e

    echo "$result"

    case $status in 
        0) [[ $result == 'No tests to run.' ]] && exit 1 ;;
        *) exit $status ;;
    esac

    echo
    echo "Checking that the Stub file *fails* the tests"

    # Copy the stub solution to the temporary directory
    cp "${files[solution]}" "${tmp_path}/${snake_name}.odin"

    # Run the test. If it passes, exit with a message and an error.
    # TODO: Check that the stub fails _all_ the tests.
    # We only check for a single failed test here -- the stub solution could solve all the cases
    # but only fail on the most complicated one. Since the purpose of this test is mostly to
    # double-check that the example didn't accidentally get duplicated as the stub, this isn't
    # too critical for now.
    # Note that we don't pass all the compile flags: we know it won't satisfy them.
    # glennj notes: this invocation seems to leave a tmp file behind
    if odin test "${tmp_path}" 2>/dev/null ; then
        echo >&2 'ERROR: The stub file must not pass the tests!'
        exit 1
    else
        echo 'SUCCESS: The stub file failed the tests above as expected.'
    fi
}

run_test "$@"
