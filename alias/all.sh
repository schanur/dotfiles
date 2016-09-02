#!/bin/bash

SCRIPT_FILENAME=$(readlink -f $0)
SCRIPT_PATH=$(dirname $SCRIPT_FILENAME)
DOTFILES_PATH=${SCRIPT_PATH}/..

source ${DOTFILES_PATH}/lib/bash/path_variable.sh

for INC_FILE in .; do
    echo "Load alias file: ${INC_FILE}"
    . ${INC_FILE}
done
