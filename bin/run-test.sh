#!/usr/bin/env bash

# Exit script if any subcommands fail
set -euo pipefail

exercises_path="exercises/practice"

# Delete the temp directory
function cleanup {
    rm -rf "${tmp_path}"
}
# Register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

get_from_config() {
    printf "%s/%s" "${exercise_path}" "$(jq --arg type "$1" -r '.files[$type][0]' "$config")"
}

run_test() {
    local exercise_name="${1:-}"    # due to `set -u`, provide a default value

    if [[ -z "${exercise_name}" ]]; then
        echo "Running all tests"
        for exercise in "$exercises_path"/*/; do
            run_test "$(basename "$exercise")"
        done
        return
    fi

    echo "Running test for exercise: ${exercise_name}"

    local exercise_path="${exercises_path}/${exercise_name}"
    if ! [[ -d "${exercise_path}" ]]; then
        echo "unknown exercise: ${exercise_name}" >&2
        exit 1
    fi

    local config="${exercise_path}/.meta/config.json"
    local -A files
    for type in 'solution' 'example' 'test'; do
        files[$type]=$(get_from_config $type)
    done

    local snake_name=${exercise_name//-/_}
    local -g tmp_path   # the cleanup function needs a global variable
    tmp_path=$(mktemp -d)

    echo "$exercise_name / $exercise_path"

    # Copy the example file into the temporary directory
    cp "${files[example]}" "${tmp_path}/${snake_name}.odin"

    # Unskip all tests and write the processed test file to the temporary directory.
    # The test file for the exercise often has several of the tests skippped initially, so that
    # students can do test-driven development by enabling the next test, possibly see it fail,
    # and then refining their solution. However, the test runner used by contributors and the CI
    # pipeline always needs to run all tests.
    #
    # In Odin, a test can be skipped by commenting out the `@(test)` annotation preceding the
    # test procedure. Here we unskip the test by searching for `\\ @(test)` lines and replacing
    # them with `@test`.
    sed 's,// @(test),@(test),' "${files[test]}" > "${tmp_path}/${snake_name}_test.odin"

    # Run the tests using the example file to verify that it is a valid solution.
    odin test "${tmp_path}"

    echo "Checking that the Stub file *fails* the tests"

    # Copy the stub solution to the temporary directory
    cp "${files[solution]}" "${tmp_path}/${snake_name}.odin"

    # Run the test. If it passes, exit with a message and an error.
    # TODO: Check that the stub fails _all_ the tests.
    # We only check for a single failed test here -- the stub solution could solve all the cases
    # but only fail on the most complicated one. Since the purpose of this test is mostly to
    # double-check that the example didn't accidentally get duplicated as the stub, this isn't
    # too critical for now.
    # glennj notes: this invocation seems to leave a tmp file behind
    if odin test "${tmp_path}" 2>/dev/null ; then
        echo >&2
        echo >&2 'ERROR: The stub file must not pass the tests!'
        exit 1
    else
        echo
        echo 'SUCCESS: The stub file failed the tests above as expected.'
    fi
}

run_test "$@"
