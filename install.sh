#!/bin/bash

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}"

source "${DOTFILES_PATH}/lib/shell/install.sh"


function install_component() {
    local INSTALL_SCRIPT=${1}
    local INSTALL_SCRIPT_EXIT_CODE

    if [ -x "${INSTALL_SCRIPT}" ]; then
        echo "Run dotfiles install script: ${INSTALL_SCRIPT}"
        ${INSTALL_SCRIPT}
        INSTALL_SCRIPT_EXIT_CODE=${?}
        if [ "${INSTALL_SCRIPT_EXIT_CODE}" != "0" ]; then
            echo "${INSTALL_SCRIPT} failed. Abort!"
            exit 1
        fi
    else
        echo "Warning: ${INSTALL_SCRIPT} is no executable."
    fi
}


function main () {
    local INSTALL_SCRIPT
    local FIRST_FILE=1;

    for INSTALL_SCRIPT in $(find ${SCRIPT_PATH}/install ! -type d); do
        if [ ${FIRST_FILE} = "1" ]; then
            FIRST_FILE=0
        else
            echo
        fi

        if [ -x ${INSTALL_SCRIPT} ]; then
           install_component ${INSTALL_SCRIPT}
        fi
    done
}


main
