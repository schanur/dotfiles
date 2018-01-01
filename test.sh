#!/bin/bash

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}"


# Check if submodules pass tests.
# vendor/libbivalvia/test.sh


# Run all regression tests.
for TEST_SCRIPT in $(find "${DOTFILES_PATH}/test/regression" -type f); do
    echo "${TEST_SCRIPT}"
    "${TEST_SCRIPT}"
done
