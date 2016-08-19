
source ${INCLUDE_PATH}/date.sh
source ${INCLUDE_PATH}/require.sh


function ln_support_relative_linking {
    (ln --help |grep "\-r" || true) |wc -l
}

# Print link target to stdout.
function link_target {
    local LINK_NAME=${1}

    require_sybolic_link ${LINK_NAME}

    ls -la ${LINK_NAME} |sed -e 's/.*\ ->\ //g'
}

# Returns the absolute path/filename of a link target. This works no
# matter the link target is already absolute or relative to the path
# of the link.
function absolute_link_target {
    local LINK_NAME=${1}
    local LINK_TARGET
    local ABS_LINK_TARGET


    LINK_TARGET=$(link_target)
    ABS_LINK_TARGET=${LINK_TARGET}
    if [ $[LINK_TARGET:0:1] != "/" ]; then
        ABS_LINK_TARGET=$()${ABS_LINK_TARGET}
    fi
}

# If file or directory with "${LINK_NAME}" exists, rename it to
# "${LINK_NAME}.dotfiles_backup". Create a symbolic link with the name
# "${LINK_NAME}" targeting ""{LINK_TARGET}" afterwards.
function backup_config_and_create_link {
    local LINK_TARGET=${1}
    local LINK_NAME=${2}
    local BACKUP_NAME=${LINK_NAME}.dotfiles_backup.$(timestamp)

    require_file_or_directory ${LINK_TARGET}
    if [ -e ${LINK_NAME} ]; then
        echo "Backup ${LINK_NAME} -> ${BACKUP_NAME}"
        mv ${LINK_NAME} ${BACKUP_NAME}
    fi
    local CMD="ln -s ${GL_RELATIVE_LINKING_SWITCH} ${LINK_TARGET} ${LINK_NAME}"
    echo ${CMD}
    ${CMD}
}

# Prints "1" if the symbolic link ($1) targets the file/directory
# ($2). "0" otherwise.
function funtion_links_to_target {
    local EXPECTED_LINK_TARGET=${1}
    local LINK_NAME=${2}
    local RESOLVED_LINK_TARGET
    local ABS_RESOLVED_LINK_TARGET
    local FUNCTION_LINKS_TO_TARGET=0

    RESOLVED_LINK_TARGET=$(link_target ${LINK_NAME})
    echo
    echo "0 PWD:                  $(pwd)"
    # ABS_RESOLVED_LINK_TARGET=$(realpath ${RESOLVED_LINK_TARGET})
    # if [ ${ABS_RESOLVED_LINK_TARGET} = ${EXPECTED_LINK_TARGET} ]; then
    #     FUNCTION_LINKS_TO_TARGET=1
    # fi
    echo "1 EXPECTED_LINK_TARGET: ${EXPECTED_LINK_TARGET}"
    echo "2 LINK_NAME:            ${LINK_NAME}"
    echo "3 RESOLVED_LINK_TARGET: ${RESOLVED_LINK_TARGET}"
    # echo "4 ${ABS_RESOLVED_LINK_TARGET}"
    echo ${FUNCTION_LINKS_TO_TARGET}
}

# Does the same as "backup_config_and_create_link" but interpret
# "§{LINK_TARGET}" relative to dotfiles repository and ${LINK_NAME}
# relative to the home directory of the user runncing the script.
function backup_user_config_and_create_dotfiles_link {
    local LINK_TARGET=${1}
    local LINK_NAME=${2}
    local ABSOLUTE_LINK_TARGET=${LINK_TARGET}
    local ABSOLUTE_LINK_NAME=${HOME}/${LINK_NAME}
    local FUNCTION_LINKS_TO_TARGET

    funtion_links_to_target ${ABSOLUTE_LINK_TARGET} ${ABSOLUTE_LINK_NAME}
    # FUNCTION_LINKS_TO_TARGET=funtion_links_to_target ${ABSOLUTE_LINK_TARGET} ${ABSOLUTE_LINK_NAME}
    echo "##### "
    # if [ ! ${FUNCTION_LINKS_TO_TARGET} ]

    #backup_config_and_create_link ${ABSOLUTE_LINK_TARGET} ${ABSOLUTE_LINK_NAME}
}

if [ $(ln_support_relative_linking) = "1" ]; then
    GL_RELATIVE_LINKING_SWITCH="-r"
else
    GL_RELATIVE_LINKING_SWITCH=""
fi
