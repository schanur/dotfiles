
function tar_snapshot_func {
    local SNAPSHOT_FILE_LIST="$*"
    local DATETIME_SHORT_STR=$(date -Iseconds |sed -e 's/[-T:\]//g' | cut -f 1 -d '+')
    local SNAPSHOT_FILENAME="$(echo ${SNAPSHOT_FILE_LIST} | tr ' ' '+')_${DATETIME_SHORT_STR}.tar.xz"

    XZ_OPT=-9e tar cvJf ${SNAPSHOT_FILENAME} ${SNAPSHOT_FILE_LIST}
}

BACKUP_FILE_OR_PATH=${1}
BACKUP_FILENAME=${BACKUP_FILE_OR_PATH}
alias tar-snapshot='tar_snapshot_func'
