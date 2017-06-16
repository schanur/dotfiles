#!/bin/bash

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}"

vendor/libbivalvia/test.sh
# ${DOTFILES_PATH}/test/scripts-have-short-description.sh
