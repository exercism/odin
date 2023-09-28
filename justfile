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
