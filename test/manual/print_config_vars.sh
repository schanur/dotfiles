#!/bin/bash

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME=$(readlink -f $0)
SCRIPT_PATH=$(dirname $SCRIPT_FILENAME)
DOTFILES_PATH=${SCRIPT_PATH}/../..

source ${DOTFILES_PATH}/lib/bash/require.sh
source ${DOTFILES_PATH}/lib/bash/config.sh

CONFIG_FILE_LIST="rsync_home.conf"

function verbose_exec {
    local COMMAND=${*}

    echo ${COMMAND}
    ${COMMAND}
    echo
}

verbose_exec profile_path
verbose_exec global_path
verbose_exec profile_config_file_exists rsync-home.conf
verbose_exec global_config_file_exists  rsync-home.conf
verbose_exec absolute_config_file       rsync-home.conf

#verbose_exec load_config_file           rsync-home.conf
load_config_file           rsync-home.conf
# source /home/ze/local/dev/all/dotfiles/test/manual/../../config/global/rsync-home.conf

echo "RSYNC_HOME__REMOTE_USERNAME:  ${RSYNC_HOME__REMOTE_USERNAME}"
echo "RSYNC_HOME__REMOTE_HOST:      ${RSYNC_HOME__REMOTE_HOST}"
echo "RSYNC_HOME__REMOTE_BASE_PATH: ${RSYNC_HOME__REMOTE_BASE_PATH}"
