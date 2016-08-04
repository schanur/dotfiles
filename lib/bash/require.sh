
source ${INCLUDE_PATH}/debug.sh


# Check if the binary/script filename exists in a path specified in the PATH variable. If no match is found, an error message is printed to stderr and the script terminates with an error.
function require_executable {
    local EXECUTABLE_NAME=${1}
    local EXECUTABLE_FOUND=1

    which ${EXECUTABLE_NAME} > /dev/null 2>/dev/null || EXECUTABLE_FOUND=0
    if [ ${EXECUTABLE_FOUND} -ne 1 ]; then
        echo "${EXECUTABLE_NAME} not found. Abort!"
        stack_trace
        exit 1
    fi
}

function require_file {
    local FILENAME=${1}

    if [ ! -f ${FILENAME} ]; then
        echo "File not found: ${FILENAME}"
        echo "Abort!"
        stack_trace
        exit 1
    fi
}

function require_file_or_directory {
    local FILENAME=${1}

    if [[ ! -f ${FILENAME} && ! -d ${FILENAME} ]]; then
        echo "File not found: ${FILENAME}"
        echo "Abort!"
        stack_trace
        exit 1
    fi
}

function require_sybolic_link {
    local LINK_NAME=${1}

    if [ ! -h ${LINK_NAME} ]; then
        echo "Symbolic link not found: ${LINKNAME}"
        echo "Abort!"
        stack_trace
        exit 1
    fi
}
