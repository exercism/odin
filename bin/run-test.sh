#!/bin/bash

# Exit script if any subcommands fail
set -e

# Terminal color definitions
COLOR_GREEN="$(tput setaf 2)$(tput bold)"
COLOR_RED="$(tput setaf 1)$(tput bold)"
COLOR_REST="$(tput sgr0)"

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
    
        # Copy the example and test files into the temporary directory
        cp ${example_file} ${tmp_path}/${exercise_safe_name}.odin
        cp ${test_file} ${tmp_path}
    
        # Run the tests using the example file to verify that it is a valid solution.
        odin test ${tmp_path}

        echo -e "Checking that the stub solution *fails* the tests\n"

        # Copy the stub solution to the temporary directory
        cp ${solution_file} ${tmp_path}/${exercise_safe_name}.odin

        # Run the test. If it passes, exit with a message and an error.
        if odin test ${tmp_path} ; then
            printf '%s\nERROR: The stub solution must not pass the tests!\n\n' $COLOR_RED
            exit 1
        else
            printf '%s\nSUCCESS: The stub solution failed the tests above as expected.\n\n' $COLOR_GREEN
        fi

    else
        echo "Running all tests"
        for exercise in $(ls $exercises_path)
        do
            run_test $exercise
            printf "%s" $COLOR_REST
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
