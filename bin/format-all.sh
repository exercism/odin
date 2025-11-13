#!/usr/bin/env bash

# Runs `odinfmt` on all .odin files in the current tree.

if ! command -v odinfmt >/dev/null 2>&1; then
    bin_dir=$(realpath "$(dirname "$0")")
    {
        echo 'odinfmt not found.'
        echo
        echo 'Do you need to install it?'
        echo "=> ${bin_dir}/fetch-old-odinfmt.sh"
        echo
        echo 'Do you need to add ./bin to the PATH?'
        echo "=> PATH=\$PATH:${bin_dir} $0"
    } >&2
    exit 1
fi

find . -type f -name "*.odin" -exec odinfmt -w {} \;
echo "All Odin files have been formatted."
