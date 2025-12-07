#!/usr/bin/env bash

to_snake_case() {
    sed -E '
        s/[ -]/_/g
        s/([[:lower:][:digit:]])([[:upper:]])/\1_\2/g
        s/ = /_equals_/g
        s/[^[:alnum:]_]//g
    ' | tr '[:upper:]' '[:lower:]'
}

if [[ $# -ne 1 ]]; then
  echo "Usage: to_snake_case <sentence>"
  exit 1
fi

to_snake_case "$1"
