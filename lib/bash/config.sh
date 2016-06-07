#!/bin/bash

# function user_has_profile_path {
#     local PATH_EXIST
#     local HOSTNAME=$(hostname)
# }

function profile_path_contains_config_file {
    true
}

function load_config_file {
    local RELATIVE_CONFIG_FILENAME=${1}

    local HOSTNAME=$(hostname)


    source
}
