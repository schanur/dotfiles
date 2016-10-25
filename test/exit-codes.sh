#!/bin/bash

#

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME=$(readlink -f $0)
SCRIPT_PATH=$(dirname $SCRIPT_FILENAME)
DOTFILES_PATH=${SCRIPT_PATH}/..

source ${DOTFILES_PATH}/lib/bash/require.sh
source ${DOTFILES_PATH}/lib/bash/config.sh


