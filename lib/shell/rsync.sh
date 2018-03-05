function rsync_exclude_file_parameter_list {
    local RSYNC_EXCLUDE_PARAMETER_LIST=""

    for EXCLUDE_FILE in $(find "${DOTFILES_PATH}/data/home-backup-exclude/" ! -type d); do
        RSYNC_EXCLUDE_PARAMETER_LIST="${RSYNC_EXCLUDE_PARAMETER_LIST} --exclude-from=${EXCLUDE_FILE}"
    done

    echo "${RSYNC_EXCLUDE_PARAMETER_LIST}"
}
