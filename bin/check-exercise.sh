#!/usr/bin/env bash

# Exit script if any subcommands fail
set -eou pipefail

die () { echo "$*" >&2; exit 1; }

expected_number_of_tests () {
    num_tests="0"
    ignored_tests="0"
    if [ -f "${exercise_path}/.meta/tests.toml" ]; then
      num_tests=$(grep -c "description = " "${exercise_path}/.meta/tests.toml")
      ignored_tests=$(grep -c "include = false" "${exercise_path}/.meta/tests.toml")
    fi
    echo $(( num_tests - ignored_tests ))
}

actual_number_of_tests () {
    grep -c "^[[:space:]]*@(test)" "${exercise_path}/${exercise_name}_test.odin"
}

create_temp_dir () {
    # Need to create the tempdir relative to the current dir
    # so that it can find the odinfmt config file.
    TEMP_DIR=$(TMPDIR= mktemp -d -p "$PWD" -t check-exercise-XXXXXXXX) \
    || die "Error: Failed to create temporary directory."
}

cleanup_temp_dir () {
    # -r: recursively delete contents; -f: force deletion (no prompts)
    # if directory does not exist, -f does not complain
    rm -rf "$TEMP_DIR"
}

check_format () {
    file_type=$1
    src_file=$2
    tmp_file="${TEMP_DIR}/$(basename "${src_file}")"

    cp "${src_file}" "${tmp_file}"
    bin/odinfmt -w "${tmp_file}"
    if diffs=$( diff "${src_file}" "${tmp_file}" ); then
        log_result "Exercise ${file_type} formatting" "[OK]✅"
    else
        echo "❌[ERROR] ${src_file} is incorrectly formatted (run 'bin/odinfmt -w <filepath>'):"
        echo "$diffs"
        exit 1
    fi
}

check_for_missing_test_descriptions () {
if awk_output=$(awk '
BEGIN {
    saw_test_line = 0
    test_line_number = 0
    exit_status = 0
}
/^@\(test\)/ {
    if (saw_test_line == 1) {
        print "[ERROR] Missing /// description = ... for test starting at line " test_line_number
        exit_status = 1
    }
    saw_test_line = 1
    test_line_number = NR
    next
}
/^\/\/\/ description = / {
    if (saw_test_line == 1) {
        saw_test_line = 0
        test_line_number = 0
    }
    next
}
/ :: proc\(/ {
    if (saw_test_line == 1) {
        print "[ERROR] Missing /// description = ... for test starting at line " test_line_number
        saw_test_line = 0
        test_line_number = 0
        exit_status = 1
    }
    next
}
END {
    if (saw_test_line == 1) {
        print "[ERROR] File ended unexpectedly after @(test) on line " test_line_number
        exit_status = 1
    }
    exit exit_status
};
' "$1"); then
  log_result "Exercise ${file_type} description tags" "[OK]✅"
else
  echo "❌[ERROR] $1 is missing description tags (run 'bin/fix-description-tags.sh')"
  echo "$awk_output"
  exit 1
fi

}

log_result () {
    printf '    %-35s: %s\n' "$1" "$2"
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
        echo "⚠️[WARNING] More expected tests than actuals, please check ${exercise_path}/.meta/tests.toml"
    elif [[ $num_expected_tests -lt $num_actual_tests ]]; then
        echo "❓[INFO] More actual tests than expected tests, looks like you over-achieved!"
    fi
fi

if test_output=$( bin/run-test.sh "$exercise_path" 2>&1 ); then
    log_result "Running tests" "[OK]✅"
else
    echo  "❌[ERROR] Tests fail"
    echo "$test_output" | grep -v "\[INFO \]"
    exit 1
fi

check_format stub "${exercise_path}/${exercise_name}.odin"
check_format tests "${exercise_path}/${exercise_name}_test.odin"
check_format example "${exercise_path}/.meta/example.odin"
check_for_missing_test_descriptions "${exercise_path}/${exercise_name}_test.odin"

    if [ -f ODIN_VERSION ]; then
        local_version=$(odin version | sed -E 's/:.*$//' | sed -E 's/^odin version //')
        supported_version=$(cat ODIN_VERSION | sed -E 's/^odin version //')
        if [[ "$local_version" != "$supported_version" ]]; then
            echo "⚠️[WARNING] Project's Odin version is: $supported_version but your local version is: $local_version"
        fi
    fi

echo "Exercise $exercise_name pass all the checks!"
