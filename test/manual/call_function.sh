#!/bin/bash

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/../.."

source "${DOTFILES_PATH}/lib/bash/debug.sh"


function test_local_vars {
    local TEST_1=0
    local TEST_2=1

    stack_trace

}

test_local_vars
