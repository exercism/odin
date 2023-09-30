# Don't know what this file is for? See:
# https://github.com/casey/just

# https://github.com/casey/just#table-of-settings
set dotenv-load
set export

default:
  @just --list

build:
  @echo "Building..."

test:
  @echo "Testing..."

lint:
  @echo "Linting..."

alias gt := generate-test
generate-test slug:
  odin run \
    src/generate_test.odin \
    -file \
    -show-timings \
    -collection:shared=src

check:
  odin check \
    src/ \
    -vet \
    # -vet-extra \
    -strict-style \
    -warnings-as-errors \
    -collection:shared=src