
if [ ! -d ".emace.s/.git" ]; then
    echo "git clone emacs config"
    if [ -d ".emacs.d" ]; then
        echo "  Backup .emacs folder"
        mv .emacs.d .emacs.d.pre-auto-install-script
    fi
    ln -s local/dev/emacs.d .emacs.d
fi

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
    local BACKUP_NAME=${LINK_NAME}.dotfiles_backup

    require_file ${LINK_TARGET}
    if [ -e ${LINK_NAME} ]; then

        echo "  Backup ${LINK_NAME} -> ${CONFIG_BACKUP_NAME}"
        mv ${LINK_NAME} ${BACKUP_NAME}
    fi
    ln -s -r ${LINK_TARGET} ${LINK_NAME}

    local REPO_PATH=${SCRIPT_PATH}/../tmux
    local CMD="ln -s -r ${SCRIPT_PATH}/../profile/profile .profile"

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

    backup_config_and_create_link
}
