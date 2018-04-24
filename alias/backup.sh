
function tar_snapshot_func {
    local SNAPSHOT_FILE_LIST="$*"
    local DATETIME_SHORT_STR=$(date -Iseconds |sed -e 's/[-T:\]//g' | cut -f 1 -d '+')
    local SNAPSHOT_FILENAME="$(echo ${SNAPSHOT_FILE_LIST} | tr ' ' '+')_${DATETIME_SHORT_STR}.tar.xz"

    XZ_OPT=-9e tar cvJf "${SNAPSHOT_FILENAME}" ${SNAPSHOT_FILE_LIST}
}

function tar_snapshot_to_backup_dir_func {
    local SNAPSHOT_FILE_LIST="$*"
    local BACKUP_PATH="${HOME}/local/backup"
    local DATETIME_SHORT_STR=$(date -Iseconds |sed -e 's/[-T:\]//g' | cut -f 1 -d '+')
    local SNAPSHOT_FILENAME="$(echo ${SNAPSHOT_FILE_LIST} | tr ' ' '+')_${DATETIME_SHORT_STR}.tar.xz"

    XZ_OPT=-9e tar cvJf "${SNAPSHOT_FILENAME}" ${SNAPSHOT_FILE_LIST}
    if [ ! -d "${BACKUP_PATH}" ]; then
        echo "Backup path '${BACKUP_PATH}' does not exist. Creating it."
        mkdir "${BACKUP_PATH}"
    fi
    mv -v "${SNAPSHOT_FILENAME}" "${BACKUP_PATH}"
}

alias tar-snapshot='tar_snapshot_func'
alias tar-snapshot-to-backup-path='tar_snapshot_to_backup_dir_func'
