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
    printf "%s/%s" "${exercise_path}" "$(jq --arg type "$1" -r '.files[$type][0]' "$config")"
}

check_skipped_tests() {
    local test_file=$1
    local count
    count=$( grep -Ec '^[[:blank:]]*@\(test\)' "$test_file" )
    if (( count != 1 )); then
        printf '[ERROR] There should be exactly 1 unskipped test in %s\n\n' "${test_file}" >&2
        exit 2
    fi
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
    for type in 'solution' 'example' 'test'; do
        files[$type]=$(get_from_config $type)
    done

    local snake_name=${exercise_name//-/_}
    local -g tmp_path   # the cleanup function needs a global variable
    tmp_path=$(mktemp -d)

    echo "$exercise_name / $exercise_path"

    check_skipped_tests "${files[test]}"

    # Copy the example file into the temporary directory
    cp "${files[example]}" "${tmp_path}/${snake_name}.odin"

    # Unskip all tests and write the processed test file to the temporary directory.
    # The test file for the exercise often has several of the tests skippped initially, so that
    # students can do test-driven development by enabling the next test, possibly see it fail,
    # and then refining their solution. However, the test runner used by contributors and the CI
    # pipeline always needs to run all tests.
    #
    # In Odin, a test can be skipped by commenting out the `@(test)` annotation preceding the
    # test procedure. 
    sed 's,//[[:space:]]*@(test),@(test),' "${files[test]}" > "${tmp_path}/${snake_name}_test.odin"

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
