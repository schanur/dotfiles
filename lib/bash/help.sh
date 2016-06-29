
function script_name {
    echo $(basename ${0})
}

function short_description {
    local SCRIPT_FILE=${1}
    local THIRD_LINE
    local SHORT_DESCRIPTION

    THIRD_LINE=$(cat ${SCRIPT_FILE} |head -n 3 |tail -n 1)
    if [ "${THIRD_LINE:0:2}" = "# " ]; then
        SHORT_DESCRIPTION=${THIRD_LINE:2}
    else
        # SHORT_DESCRIPTION=${THIRD_LINE:2}
        SHORT_DESCRIPTION="No description available"
    fi

    echo ${SHORT_DESCRIPTION}
}

function long_description {
    local
}

# Print the help section of a script, consisting of the script name,
# the short description and the long description.
function help {
    echo $()
    echo
    echo $(get_short_description)
    echo
    echo ${get_long_description}
}

# The script was called with a wron number of arguments or the
# arguments cannot be parsed. We print the help section of the script
# and exit with error code 64.
function invalid_parameter_exit {
    echo $(help)
    echo
    echo "Error: Invalid parameter."

    # The proper exit code is defined in "sysexits.h"
    #define EX_USAGE        64      /* command line usage error */
    exit 64
}
