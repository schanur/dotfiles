#!/bin/bash

SCRIPT_FILENAME=$(readlink -f $0)
SCRIPT_PATH=$(dirname $SCRIPT_FILENAME)
INCLUDE_PATH=${SCRIPT_PATH}/shared_bash

source ${INCLUDE_PATH}/path_variable.sh

for INC_FILE in .; do
    echo "Load alias file: ${INC_FILE}"
    . ${INC_FILE}
done
