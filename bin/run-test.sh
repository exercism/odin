#!/bin/bash

# Exit script if any subcommands fail
set -e

# TODO: Pull info from config, similar to how the Zig track does it:
# https://github.com/exercism/zig/blob/main/bin/run-tests

function to_snake_case() {
    tr ' ' '_' | tr '-' '_'| sed -r 's/([a-z0-9])([A-Z])/\1_\2/g' | sed -r 's/[^a-zA-Z0-9_]//g' | tr '[:upper:]' '[:lower:]'
}

function run_test() {
    exercises_path="exercises/practice"
    meta=".meta"
    exercise_name="${1}"
    exercise_path="${exercises_path}/${exercise_name}"
    tmp_path=`mktemp -d`

    echo "$exercise_name / $exercise_path"
    
    if [ -n "${exercise_name}" ] && [ -d "${exercise_path}" ]; then
        echo -e "Running test for exercise: ${exercise_name}\n"
    
        # Turn something like "hello-world" into "hello_world"
        exercise_safe_name=$(echo $exercise_name | to_snake_case)
    
        # "exercises/practice/hello_world.odin"
        solution_file="${exercise_path}/${exercise_safe_name}.odin"
    
        # "exercises/practice/hello_world_test.odin"
        test_file="${exercise_path}/${exercise_safe_name}_test.odin"
    
        # "exercises/practice/.meta/hello_world_example.odin"
        example_file="${exercise_path}/${meta}/${exercise_safe_name}_example.odin"
    
        # Copy the example file into the temporary directory
        cp ${example_file} ${tmp_path}/${exercise_safe_name}.odin

        # Unskip all tests and write the processed test file to the temporary directory.
        # The test file for the exercise often has several of the tests skippped initially, so that
        # students can do test-driven development by enabling the next test, possibly see it fail,
        # and then refining their solution. However, the test runner used by contributors and the CI
        # pipeline always needs to run all tests.
        #
        # In Odin, a test can be skipped by commenting out the `@(test)` annotation preceding the
        # test procedure. Here we unskip the test by searching for `\\ @(test)` lines and replacing
        # them with `@test`.
        sed s/"\/\/ @(test)"/"@(test)"/ ${test_file} > ${tmp_path}/${exercise_safe_name}_test.odin
    
        # Run the tests using the example file to verify that it is a valid solution.
        odin test ${tmp_path}

        echo -e "Checking that the stub solution *fails* the tests\n"

        # Copy the stub solution to the temporary directory
        cp ${solution_file} ${tmp_path}/${exercise_safe_name}.odin

        # Run the test. If it passes, exit with a message and an error.
        if odin test ${tmp_path} ; then
            echo -e '\nERROR: The stub solution must not pass the tests!\n'
            exit 1
        else
            echo -e '\nSUCCESS: The stub solution failed the tests above as expected.\n'
        fi

    else
        echo "Running all tests"
        for exercise in $(ls $exercises_path)
        do
            run_test $exercise
        done
    fi
}

# Delete the temp directory
function cleanup {
    rm -rf ${tmp_path}
}

# Register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

run_test $@
