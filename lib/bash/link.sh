
source ${INCLUDE_PATH}/date.sh
source ${INCLUDE_PATH}/require.sh


# Print link target to stdout.
function link_target {
    local LINK_NAME=${1}

    require_sybolic_link ${LINK_NAME}

    ls -la ${LINK_NAME} |sed -e 's/.*\ ->\ //g'
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
    local CMD="ln -s -r ${LINK_TARGET} ${LINK_NAME}"
    echo ${CMD}
    ${CMD}
}

# Does the same as "backup_config_and_create_link" but interpret
# "§{LINK_TARGET}" relative to dotfiles repository and ${LINK_NAME}
# relative to the home directory of the user runncing the script.
function backup_user_config_and_create_dotfiles_link {
    local LINK_TARGET=${1}
    local LINK_NAME=${2}
    local ABSOLUTE_LINK_TARGET=${LINK_TARGET}
    local ABSOLUTE_LINK_NAME=${HOME}/${LINK_NAME}

    backup_config_and_create_link ${ABSOLUTE_LINK_TARGET} ${ABSOLUTE_LINK_NAME}
}
