#!/bin/bash

# Sometimes packages get remove from their Linux distribution
# repository. Check that all packages in all package groups are still
# available.

#

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/../.."

# source "${DOTFILES_PATH}/lib/bivalvia/require.sh"
source "${DOTFILES_PATH}/lib/bivalvia/package_management_deb.sh"


cd "${DOTFILES_PATH}/data/debian-package-groups/generic"

for PACKAGE_FILE in $(find . -type f); do
    cat "${PACKAGE_FILE}" | cut -f 1 -d '#' | sed -e 's/\ //g' | grep -v -e "^$" | while read PACKAGE_NAME; do
        if [ $(deb_package_available_in_repos "${PACKAGE_NAME}") = "0" ]; then
            echo "Package not in repository: ${PACKAGE_NAME} from package group ${PACKAGE_FILE}"
        fi
        # echo ${PACKAGE_NAME}
    done
done
