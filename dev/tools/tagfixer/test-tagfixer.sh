#!/usr/bin/env bash

# This script tests the tagfixer tool.
# It runs it on the rational_number_tests.odin in the example
# directory and compare the result to the expected
# output.
# Note: there are tests for special_cases added to the
# bottom of the rational_number_tests.odin.
#

# Exit script if any subcommands fail
set -eo pipefail

test_file=example/rational_numbers_test.odin
#cdata_file=example/canonical-data.json
cdata_file=example/tests.toml
exp_out_file=example/expected_rational_numbers_test.odin
out_file=example/updated_rational_numbers_test.odin

echo "Testing tagfixer..."

rm -f "$out_file"
odin run . -- "$test_file" "$cdata_file" "$out_file"

if diff -w "$out_file" "$exp_out_file" >/dev/null; then
  echo "  PASS"
else
  echo "  FAIL: generated file doesn't match expected results:"
  diff -w "$out_file" "$exp_out_file"
fi
