#!/bin/bash

#

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/.."

source "${DOTFILES_PATH}/lib/bivalvia/require.sh"
source "${DOTFILES_PATH}/lib/bivalvia/config.sh"


dotfiles \
    | sed -e 's/\ \ \ \ \ \ \ \ /\ /g' \
    | sed -e 's/\ \ \ \ /\ /g'         \
    | sed -e 's/\ \ /\ /g'             \
    | sed -e 's/\ \ /\ /g'             \
    |                                  \
    while read DOTFILES_CMD_DESC; do   \
        echo ${DOTFILES_CMD_DESC}
        SCRIPT_NAME=$(      echo ${DOTFILES_CMD_DESC} |cut -f 1 -d " " )
        SHORT_DESCRIPTION=$(echo ${DOTFILES_CMD_DESC} |cut -f 2 -d " " )
        echo "### ${SCRIPT_NAME} ${SHORT_DESCRIPTION}"
        echo "--------------------------"
        # if [ "${DOTFILES_CMD_DESC}" = "" ]; then
        # fi
    done

#    | sed -e 's/^[^\ ]*\ //g'          \
