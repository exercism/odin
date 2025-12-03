#!/usr/bin/env bash

die () { echo "$*" >&2; exit 1; }

expected_number_of_tests () {
    num_tests=$(grep -c "description = " "${exercise_path}/.meta/tests.toml")
    ignored_tests=$(grep -c "include = false" "${exercise_path}/.meta/tests.toml")
    echo $(( num_tests - ignored_tests ))
}

actual_number_of_tests () {
    grep -c "^[[:space:]]*@(test)" "${exercise_path}/${exercise_name}_test.odin"
}

create_temp_dir() {
    # Need to create the tempdir relative to the current dir
    # so that it can find the odinfmt config file.
    TEMP_DIR=$(TMPDIR= mktemp -d -p "$PWD" -t check-exercise-XXXXXXXX) \
    || die "Error: Failed to create temporary directory."
}

cleanup_temp_dir() {
    # -r: recursively delete contents; -f: force deletion (no prompts)
    # if directory does not exist, -f does not complain
    rm -rf "$TEMP_DIR"
}

# There is a weird bug where `odinfmt srcfile > outfile` inserts an extra trailing blank
# line where `odinfmt -w srcfile` doesn't. This theows the formatting comparisons off.
# For now, we will just copy srcfile to outfile and run `odinfmt -w` to compare
# the files.
# Long Term we need to figure out if there is a bug in odimfmt.

# Another (simpler) solution would be to just reformat automatically as part of
# `check-exercise.sh`

check_format () {
    file_type=$1
    src_file=$2
    tmp_file="${TEMP_DIR}/$(basename "${src_file}")"

    cp "${src_file}" "${tmp_file}"
    bin/odinfmt -w "${tmp_file}"
    if diffs=$( diff "${src_file}" "${tmp_file}" ); then
        log_result "Exercise ${file_type} formatting" okay
    else
        echo "${src_file} is incorrectly formatted (run 'bin/odinfmt -w <filepath>'):"
        echo "$diffs"
        exit 1
    fi
}

log_result () {
    printf '    %-30s: %s\n' "$1" "$2"
}

if [[ $# -ne 1 || $1 == '-h' || $1 == '--help' ]]; then
    die "Usage: bin/check-exercise.sh <path to exercise>"
fi

exercise_path="$1"
exercise_name=$(basename "$1")
exercise_name=${exercise_name//-/_}

trap cleanup_temp_dir EXIT INT TERM
create_temp_dir

echo "Checking exercise: $exercise_name"

num_actual_tests=$(actual_number_of_tests)
log_result "Actual number of tests" "$num_actual_tests"

# Only practice exercises have a set of expected tests
# documented in `.meta/tests.toml`
if [[ "$exercise_path" == *"practice"* ]]; then

    num_expected_tests=$(expected_number_of_tests)
    log_result "Expected number of tests" "$num_expected_tests"

    if [[ $num_expected_tests -gt $num_actual_tests ]]; then
        echo "    [WARNING]: More expected tests than actuals, please check ${exercise_path}/.meta/tests.toml"
    elif [[ $num_expected_tests -lt $num_actual_tests ]]; then
        echo "    [INFO]: More actual tests than expected tests, looks like you over-achieved!"
    fi
fi

if test_output=$( bin/run-test.sh "$exercise_path" 2>&1 ); then
    log_result "Running tests" okay
else
    log_result "Running tests" "NOT OK"
    echo "$test_output"
    exit 1
fi

check_format stub "${exercise_path}/${exercise_name}.odin"
check_format tests "${exercise_path}/${exercise_name}_test.odin"
check_format example "${exercise_path}/.meta/example.odin"

echo "Exercise $exercise_name pass all the checks!"
