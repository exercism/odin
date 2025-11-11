#!/usr/bin/env bash

# Exit script if any subcommands fail
set -euo pipefail

# TODO: Pull info from config, similar to how the Zig track does it:
# https://github.com/exercism/zig/blob/main/bin/run-tests

to_snake_case() {
    sed -E '
        s/[ -]/_/g
        s/([a-z0-9])([A-Z])/\1_\2/g
        s/[^a-zA-Z0-9_]//g
        s/[[:upper:]]/[[:lower:]]/g
    ' <<< "${1:-}"
}

exercises_path="exercises/practice"
meta=".meta"

# Delete the temp directory
function cleanup {
    rm -rf "${tmp_path}"
}
# Register the cleanup function to be called on the EXIT signal
trap cleanup EXIT


run_test() {
    local exercise_name="${1:-}"    # due to `set -u`, provide a default value
    local exercise_path="${exercises_path}/${exercise_name}"
    local exercise_safe_name solution_file test_file example_file
    local -g tmp_path   # the cleanup function needs a global variable
    tmp_path=$(mktemp -d)

    echo "$exercise_name / $exercise_path"

    if [[ -n "${exercise_name}" ]] && [[ -d "${exercise_path}" ]]; then
        echo "Running test for exercise: ${exercise_name}"

        # Turn something like "hello-world" into "hello_world"
        exercise_safe_name=$(to_snake_case "$exercise_name")

        # "exercises/practice/hello_world.odin"
        solution_file="${exercise_path}/${exercise_safe_name}.odin"

        # "exercises/practice/hello_world_test.odin"
        test_file="${exercise_path}/${exercise_safe_name}_test.odin"

        # "exercises/practice/.meta/hello_world_example.odin"
        example_file="${exercise_path}/${meta}/${exercise_safe_name}_example.odin"

        # Copy the example file into the temporary directory
        cp "${example_file}" "${tmp_path}/${exercise_safe_name}.odin"

        # Unskip all tests and write the processed test file to the temporary directory.
        # The test file for the exercise often has several of the tests skippped initially, so that
        # students can do test-driven development by enabling the next test, possibly see it fail,
        # and then refining their solution. However, the test runner used by contributors and the CI
        # pipeline always needs to run all tests.
        #
        # In Odin, a test can be skipped by commenting out the `@(test)` annotation preceding the
        # test procedure. Here we unskip the test by searching for `\\ @(test)` lines and replacing
        # them with `@test`.
        sed 's,// @(test),@(test),' "${test_file}" > "${tmp_path}/${exercise_safe_name}_test.odin"

        ls -l
        # Run the tests using the example file to verify that it is a valid solution.
        odin test "${tmp_path}"

        ls -l

        echo "Checking that the Stub file *fails* the tests"

        # Copy the stub solution to the temporary directory
        cp "${solution_file}" "${tmp_path}/${exercise_safe_name}.odin"

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

        ls -l

    else
        echo "Running all tests"
        for exercise in "$exercises_path"/*/; do
            run_test "$(basename "$exercise")"
        done
    fi
}

run_test "$@"
