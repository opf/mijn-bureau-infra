#!/usr/bin/env bash

# This script formats the codebase using Prettier.
# Usage: ./scripts/test.sh

# Check if Prettier is installed
if ! command -v conftest &> /dev/null; then
  echo "conftest could not be found. Please install it. For more information visit https://www.conftest.dev/install/"
  exit 1
fi

# Format the codebase using Prettier
echo "testing codebase with conftest..."
conftest test
