
function script_name {
    echo $(basename ${0})
}

function comment_section_count {
    echo "Not implemented"
    exit 1
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
    true
    # local
}

# Print the help section of a script, consisting of the script name,
# the short description and the long description.
function help {
    local SCRIPT_NAME="$(script_name)"

    echo ${SCRIPT_NAME}
    echo
    echo $(short_description ${SCRIPT_FILENAME})
    echo
    echo $(long_description ${SCRIPT_FILENAME})
}

# If the first parameter is "--help" or "-h", print the help to stdout
# and exit without error.
function parse_help_parameter {
    if [ ${#} -eq 1 ]; then
        case ${1} in
            '--help'|'-h')
                help
                exit 0
                ;;
        esac
    fi
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


parse_help_parameter "${@}"
