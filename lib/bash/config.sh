
# function user_has_profile_path {
#     local PATH_EXIST
#     local HOSTNAME=$(hostname)
# }

source ${DOTFILES_PATH}/lib/bash/csv.sh


CONFIG_PATH=${SCRIPT_PATH}/../config


function profile_path {
    local HOSTNAME=$(hostname)
    local PROFILE_PATH=${CONFIG_PATH}/profile/${HOSTNAME}

    echo ${PROFILE_PATH}
}

function global_path {
    local GLOBAL_PATH=${CONFIG_PATH}/global

    echo ${GLOBAL_PATH}
}

function profile_config_file_exists {
    local RELATIVE_CONFIG_FILENAME=${1}
    local PROFILE_PATH=$(profile_path)
    local CONTAINS_CONFIG_FILE=0

    if [ -d ${PROFILE_PATH} ]; then
        if [ -r ${PROFILE_PATH}/${RELATIVE_CONFIG_FILENAME} ]; then
            CONTAINS_CONFIG_FILE=1
        fi
    fi

    return ${CONTAINS_CONFIG_FILE}
}

function global_config_file_exists {
    local RELATIVE_CONFIG_FILENAME=${1}
    local GLOBAL_PATH=$(global_path)
    local CONTAINS_CONFIG_FILE=0

    if [ -d ${GLOBAL_PATH} ]; then
        if [ -r ${GLOBAL_PATH}/${RELATIVE_CONFIG_FILENAME} ]; then
            CONTAINS_CONFIG_FILE=1
        fi
    fi

    return ${CONTAINS_CONFIG_FILE}
}

function absolute_config_file {
    local RELATIVE_CONFIG_FILENAME=${1}
    local ABSOLUTE_CONFIG_FILENAME

    if [ $(profile_config_file_exists) ]; then
        true
    elif [ $(global_config_file_exists) ]; then
        true
    else
        true
    fi
}

function load_config_file {
    local RELATIVE_CONFIG_FILENAME=${1}
    local

    source
}
