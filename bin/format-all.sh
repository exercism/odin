#!/usr/bin/env bash

# Runs `odinfmt` on all .odin files in the current tree.
bin_dir=$(realpath "$(dirname "$0")")

[[ -x "${bin_dir}/odinfmt" ]] || "${bin_dir}"/fetch-ols-odinfmt.sh || exit 1

echo
echo "Formatting..."

find . -type f -name "*.odin" -exec "${bin_dir}/odinfmt" -w {} \;

echo "All Odin files have been formatted."
