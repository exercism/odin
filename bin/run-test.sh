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
    
    if [ -n "${exercise_name}" ] && [ -d "${exercise_path}" ]; then
        echo "Running test for exercise: ${exercise_name}"
    
        # Turn something like "hello-world" into "hello_world"
        exercise_safe_name=$(echo $exercise_name | to_snake_case)
    
        # "exercises/practice/hello_world.odin"
        solution_file="${exercise_path}/${exercise_safe_name}.odin"
    
        # "exercises/practice/hello_world_test.odin"
        test_file="${exercise_path}/${exercise_safe_name}_test.odin"
    
        # "exercises/practice/.meta/hello_world_example.odin"
        example_file="${exercise_path}/${meta}/${exercise_safe_name}_example.odin"
    
        # Move the blank solution file into the meta directory for a bit
        mv ${solution_file} ${exercise_path}/${meta}
    
        # Copy the example file into the main directory
        cp ${example_file} ${solution_file}
    
        # Run the tests using the example file
        odin test ${exercise_path}
    
        # Move the blank solution file back into the main directory
        mv "${exercise_path}/${meta}/${exercise_safe_name}.odin" ${solution_file}

        # Remove the built executable
        rm -f ${exercise_name}
    else
        echo "Running all tests"
        for exercise in $(ls $exercises_path)
        do
            run_test $exercise
        done
    fi
}

run_test $@