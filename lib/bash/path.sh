
# Prints absolute path of file. If the parameter is a directory, the
# parent directory is printed.
function absolute_path {
    local FILE=${1}
    local ABS_PATH

    require_exists ${FILE}

    ABS_PATH="$(dirname $(readlink -f ${FILE}))"

    echo ${ABS_PATH}
}

# Prints a file with absolute path.
function with_absolute_path {
    local FILE=${1}
    local BASENAME
    local ABSOLUTE_PATH
    local WITH_ABSOLUTE_PATH

    require_exists ${FILE}

    BASENAME="$(basename ${FILE})"
    ABSOLUTE_PATH="$(absolute_path ${FILE})"
    WITH_ABSOLUTE_PATH="${ABSOLUTE_PATH}/${BASENAME}"

    echo ${WITH_ABSOLUTE_PATH}
}

## Maybe useful on systems where readlink is not supported or behaves
## differently (Mac OS).

# function with_absolute_path {
#     local ="$1"
#     if [ -d "$path" ]
#     then
#         echo "$(cd "$path" ; pwd)"
#     else
#         local b=$(basename "$path")
#         local p=$(dirname "$path")
#         echo "$(cd "$p" ; pwd)/$b"
#     fi
# }
