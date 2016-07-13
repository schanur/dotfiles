
function script_name {
    echo $(basename ${0})
}

function comment_section_count {
    echo "Not implemented"
    exit 1
}

function clear_section_positions {
    true
}

function parse_section_positions {
    local SCRIPT_NAME=${1}
    local EMPTY_LINE
    local IN_SECTION=0
    local LINE_NO

    LINE_NO=0
    echo "${SCRIPT_NAME}"
    while read LINE; do
        echo -n "${LINE_NO}: ${LINE}"
        if [ ${#LINE} -eq 0 ]; then
            echo -n "1"
            EMPTY_LINE=1
        elif [ "${LINE:0:1}" = " " ]; then
            echo -n "2"
            EMPTY_LINE=1
        elif [ "${LINE:0:1}" = "#" ]; then
            echo -n "3"
            EMPTY_LINE=0
        elif [ ${IN_SECTION} -eq 1 ]; then
            echo "Parse error in line ${LINE_NO}. Abort"
            exit 1
        fi
        if [ ${EMPTY_LINE} -eq 1 ]; then
            if [ ${IN_SECTION} -eq 1 ]; then
                # Last section got closed.
                IN_SECTION=0
                echo -n "a"
            else
                # Another empty line. Do nothing
                true
                echo -n "b"
            fi
        else
            if [ ${IN_SECTION} -eq 1 ]; then
                # Current section is at least one line longer.
                GL_SECTION_POS_END[${GL_SECTION_CNT}]=${LINE_NO}
                echo -n "c"
            else
                 echo "###"
                # New section started.
                (( GL_SECTION_CNT++ ))
                GL_SECTION_POS_START[${GL_SECTION_CNT}]=${LINE_NO}
                echo -n "d"
            fi
        fi
        echo
        (( LINE_NO++ ))
    done <${SCRIPT_NAME}
    if [ ${IN_SECTION} -eq 1 ]; then
        echo "Parse error in line ${LINE_NO}. Still in section. Abort"
    fi
    exit 1
    echo "Number of sections: ${GL_SECTION_CNT}"
    for (( I=1 ; I<=${GL_SECTION_CNT} ; I++ )); do
        true
        # echo "Start: ${GL_SECTION_POS_START[${I}]} End: ${GL_SECTION_POS_END[${I}]}"
    done
}

# Print the text of a section of a script. The first parameter is the
# script filename. The second one is the section number.
# Currently allowed section numbers:
# 1) Shebang
# 2) Short description
# 3) Long description
# 4) Usage
function section {
    local SECTION_NUMBER=${2}
}

function short_description {
    local SCRIPT_NAME=${1}
    local THIRD_LINE
    local SHORT_DESCRIPTION

    parse_section_positions ${SCRIPT_NAME}
    exit 1

    THIRD_LINE=$(cat ${SCRIPT_NAME} |head -n 3 |tail -n 1)
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

function usage {
    echo "Not implemented"
    exit 1
}

# Print the help section of a script, consisting of the script name,
# the short description and the long description.
function help {
    local SCRIPT_NAME="$(script_name)"

    echo ${SCRIPT_NAME}
    echo
    # echo $(short_description ${SCRIPT_FILENAME})
    # echo
    # echo $(long_description ${SCRIPT_FILENAME})
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

declare -a GL_SECTION_POS_START
declare -a GL_SECTION_POS_END
GL_SECTION_CNT=0;

parse_help_parameter "${@}"
