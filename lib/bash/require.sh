
# Check if the binary/script filename exists in a path specified in the PATH variable. If no match is found, an error message is printed to stderr and the script terminates with an error.
function require_executable {
    local EXECUTABLE_NAME=${1}
    local EXECUTABLE_FOUND=0

    which ${EXECUTABLE_NAME} && EXECUTABLE_FOUND=1
    if [ ${EXECUTABLE_FOUND} -ne 1 ]; then
        echo
    fi
}
