#!/bin/bash

#

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/../.."

# echo $DOTFILES_PATH

source "${DOTFILES_PATH}/lib/bivalvia/require.sh"
# source "${DOTFILES_PATH}/lib/bash/config.sh"


# DEBIAN_PACKAGE_GROUP_PATH="${DOTFILES_PATH}/data/debian-package-groups"

DEBIAN_PACKAGE_GROUP_PATH="${DOTFILES_PATH}/data/debian-package-groups/generic"

TEST_RET_CODE=0 # Default is success.


require_directory "${DEBIAN_PACKAGE_GROUP_PATH}"
if [ $(cat "${DEBIAN_PACKAGE_GROUP_PATH}"/* | sort |uniq -c | sort | sed -e 's/^\ *//g' | grep -E -c -v "^1 ") != "0" ]; then
    for PACKAGE in $(cat "${DEBIAN_PACKAGE_GROUP_PATH}"/* | sort |uniq -c | sort | sed -e 's/^\ *//g' | grep -E -v "^1 " | cut -f 2 -d ' '); do
        echo "Package name: ${PACKAGE}"
        grep "${PACKAGE}" "${DEBIAN_PACKAGE_GROUP_PATH}"/*
        TEST_RET_CODE=1
    done
fi

exit ${TEST_RET_CODE}
