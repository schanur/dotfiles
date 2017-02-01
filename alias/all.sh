#!/bin/bash

SCRIPT_FILENAME=$(readlink -f $0)
SCRIPT_PATH=$(dirname $SCRIPT_FILENAME)
DOTFILES_PATH=${SCRIPT_PATH}/..

echo "Load alias files"
echo

for INC_FILE in $(find ${DOTFILES_PATH}/alias |grep -v "all.sh"); do
    echo "Load alias file: ${INC_FILE}"
    . ${INC_FILE}
done
