#!/bin/bash
set -o errexit -o nounset -o pipefail


set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/../.."

source "${DOTFILES_PATH}/lib/bivalvia/software_testing.sh"


# test_function_stdout debian-package-group list-groups    $(find -name)
