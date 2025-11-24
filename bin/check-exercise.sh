#!/usr/bin/env bash


if [ $# -ne 1 ]; then
    echo "Usage: bin/check-exercise.sh <path to exercise>"
    exit 1
fi

expected_number_of_tests () {
    num_tests=$(grep -c "description = " "${exercise_path}/.meta/tests.toml")
    ignored_tests=$(grep -c "include = false" "${exercise_path}/.meta/tests.toml")
    echo $(( num_tests - ignored_tests ))
}

actual_number_of_tests () {
    grep -c "@(test)" "${exercise_path}/${exercise_name}_test.odin"
}

create_temp_dir() {
    TEMP_DIR=$(mktemp -d -t check-exercise-XXXXXXXX)
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create temporary directory." >&2
        exit 1
    fi
}

cleanup_temp_dir() {
    if [ -d "$TEMP_DIR" ]; then
        # -r: recursively delete contents; -f: force deletion (no prompts)
        rm -rf "$TEMP_DIR"
    fi
}

exercise_path="$1"
exercise_name=$(basename "$1")
exercise_name=${exercise_name/-/_}

trap cleanup_temp_dir EXIT INT TERM
create_temp_dir

echo "Checking exercise: $exercise_name"

num_expected_tests=$(expected_number_of_tests)
echo "    Expected number of tests    : $num_expected_tests"

num_actual_tests=$(actual_number_of_tests)
echo "    Actual number of tests      : $num_actual_tests"

if [[ $num_expected_tests != $num_actual_tests ]]; then
  echo "Number of expected and actual tests doesn't match!"
  exit 1
fi

test_output=$(bin/run-test.sh "$exercise_path" 2>&1)
if  [ $? -eq 0 ]; then
  echo "    Running tests               : okay"
else
  echo "    Running tests:"
  echo "$test_output"
  exit 1
fi

# There is a weird bug where `odinfmt srcfile > outfile` inserts an extra trailing blank
# line where `odinfmt -w srcfile` doesn't. This theows the formatting comparisons off.
# For now, we will just copy srcfile to outfile and run `odinfmt -w` to compare
# the files.
# Long Term we need to figure out if there is a bug in odimfmt.

# Another (simpler) solution would be to just reformat automatically as part of
# `check-exercise.sh`

#bin/odinfmt "${exercise_path}/${exercise_name}.odin" > "$TEMP_DIR/${exercise_name}.odin"
cp "${exercise_path}/${exercise_name}.odin" "$TEMP_DIR/${exercise_name}.odin"
bin/odinfmt -w "$TEMP_DIR/${exercise_name}.odin"
stub_diffs=$(diff "${exercise_path}/${exercise_name}.odin" "$TEMP_DIR/${exercise_name}.odin" 2>&1)
if [ $? -eq 0 ]; then
  echo "    Exercise stub formatting    : okay"
else
  echo "${exercise_path}/${exercise_name}.odin is incorrectly formatted (run 'bin/odinfmt -w <filepath>'):"
  echo $stub_diffs
  exit 1
fi

#bin/odinfmt "${exercise_path}/${exercise_name}_test.odin" > "$TEMP_DIR/${exercise_name}_test.odin"
cp "${exercise_path}/${exercise_name}_test.odin" "$TEMP_DIR/${exercise_name}_test.odin"
bin/odinfmt -w "$TEMP_DIR/${exercise_name}_test.odin"
test_diffs=$(diff "${exercise_path}/${exercise_name}_test.odin" "$TEMP_DIR/${exercise_name}_test.odin" 2>&1)
if [ $? -eq 0 ]; then
  echo "    Exercise tests formatting   : okay"
else
  echo "${exercise_path}/${exercise_name}_test.odin is incorrectly formatted (run 'bin/odinfmt -w <filepath>'):"
  echo $test_diffs
  exit 1
fi

#bin/odinfmt "${exercise_path}/.meta/example.odin" > "$TEMP_DIR/.meta/example.odin"
cp "${exercise_path}/.meta/example.odin" "$TEMP_DIR/example.odin"
bin/odinfmt -w  "$TEMP_DIR/example.odin"
example_diffs=$(diff "${exercise_path}/.meta/example.odin" "$TEMP_DIR/example.odin" 2>&1)
if [ $? -eq 0 ]; then
  echo "    Exercise example formatting : okay"
else
  echo "${exercise_path}/.meta/example.odin is incorrectly formatted (run 'bin/odinfmt -w <filepath>'):"
  echo $example_diffs
  exit 1
fi

echo "Exercise $exercise_name pass all the checks!"
