#!/bin/bash

#

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/.."

# source "${DOTFILES_PATH}/lib/bash/require.sh"
source "${DOTFILES_PATH}/lib/bash/config.sh"


DEBIAN_PACKAGE_GROUP_PATH="${DOTFILES_PATH}/data/debian-package-groups"

if [ $(cat ${DEBIAN_PACKAGE_GROUP_PATH}/* | sort |uniq -c | sort | sed -e 's/^\ *//g' | egrep -c -v "^1 ") != "0" ]; then
    for PACKAGE in $(cat ${DEBIAN_PACKAGE_GROUP_PATH}/* | sort |uniq -c | sort | sed -e 's/^\ *//g' | egrep -v "^1 " | cut -f 2 -d ' '); do
        echo "Package name: ${PACKAGE}"
        grep "${PACKAGE}" ${DEBIAN_PACKAGE_GROUP_PATH}/*
    done
fi
