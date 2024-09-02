#!/bin/bash

# Exit script if any subcommands fail
set -e

# TODO: Pull info from config, similar to how the Zig track does it:
# https://github.com/exercism/zig/blob/main/bin/add-exercise

function to_snake_case() {
    tr ' ' '_' | tr '-' '_'| sed -r 's/([a-z0-9])([A-Z])/\1_\2/g' | sed -r 's/[^a-zA-Z0-9_]//g' | tr '[:upper:]' '[:lower:]'
}

configlet_cache="$HOME/.cache/exercism/configlet/problem-specifications/exercises"
exercises_path="exercises"
practice_exercises_path="${exercises_path}/practice"
meta=".meta"
exercise_name="${1}"
exercise_path="${practice_exercises_path}/${exercise_name}"

if [ -z "${exercise_name}" ]; then
    echo "Must give an exercise name to generate"
elif [ -d "${exercise_path}" ]; then
    echo "Exercise already exists: ${exercise_name}"
elif [ -n "${exercise_name}" ]; then
    echo "Generating test for exercise: ${exercise_name}"
    
    bin/configlet sync --update --yes --docs --metadata --exercise ${exercise_name}
    bin/configlet sync --update --tests include --exercise ${exercise_name}

    canonical_data_path="${configlet_cache}/${exercise_name}/canonical-data.json"
    canonical_data=$(cat $canonical_data_path)

    # Turn something like "hello-world" into "hello_world"
    exercise_safe_name=$(echo $exercise_name | to_snake_case)

    # The file that the user will edit to create their solution.
    # "exercises/practice/hello_world.odin"
    solution_file="${exercise_path}/${exercise_safe_name}.odin"

    # The example solution (for use in tests)
    # "exercises/practice/.meta/hello_world_example.odin"
    example_file="${exercise_path}/${meta}/${exercise_safe_name}_example.odin"

    # The test the solution will run against
    # "exercises/practice/hello_world_test.odin"
    test_file="${exercise_path}/${exercise_safe_name}_test.odin"

    # TODO: Hacky file generation with bash. Ideally we'd do this with Odin eventually

    cat > ${solution_file} <<EOL
package ${exercise_safe_name}

EOL

    unique_properties=$(echo $canonical_data | jq -r '.cases[].property' | sort -u)

    for unique_property in "${unique_properties[@]}"
    do
        safe_unique_property=$(echo $unique_property | to_snake_case)

        cat >> ${solution_file} <<EOL
${safe_unique_property} :: proc() -> string {
	return "TODO: Implement me!"
}

EOL
    done

    cat > ${test_file} <<EOL
package ${exercise_safe_name}

import "core:testing"

EOL

    canonical_data_length=$(echo $canonical_data | jq '.cases | length')
    for ((i=0; i < $canonical_data_length; i++)); do
        case=$(echo $canonical_data | jq -c ".cases[$i]")
        uuid=$(echo $case | jq -c ".uuid")
        description=$(echo $case | jq -c ".description" | to_snake_case)
        property=$(echo $case | jq -c ".property" | to_snake_case)
        input=$(echo $case | jq -c ".input")
        expected=$(echo $case | jq -c ".expected")

        # TODO: Blindly copying input doesn't work most of the time, hence why this generator should be written in Odin itself
        cat >> ${test_file} <<EOL
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
    cp ${solution_file} ${example_file}

    # echo "Formatting new Odin files:"
    # bin/odinfmt -w ${exercises_path}

    echo "Be sure to implement the following files:"
    echo -e "\t${solution_file}"
    echo -e "\t${test_file}"
    echo -e "\t${example_file}"
    echo ""
    
    echo "Running configlet lint:"
    bin/configlet lint
fi
