#!/bin/bash

# Runs `odinfmt` on all .odin files in the current tree.

find . -type f -name "*.odin" -exec odinfmt -w {} \;
echo "All Odin files have been formatted."
