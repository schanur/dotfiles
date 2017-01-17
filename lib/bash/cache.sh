
source ${DOTFILES_PATH}/lib/bash/config.sh
source ${DOTFILES_PATH}/lib/bash/require.sh


CACHE_PATH="${HOME}/.cache/dotfiles"


function cache__update {
    local OBJECT_NAME=${1}
    local OBJECT_FILENAME="${CACHE_PATH}/${OBJECT_NAME}.cache"
    shift
    local VALUE="${*}"

    echo ${VALUE} > ${OBJECT_FILENAME}
}

function cache__is_available {
    local OBJECT_NAME=${1}
    local OBJECT_FILENAME="${CACHE_PATH}/${OBJECT_NAME}.cache"
    local CACHED_VERSION_AVAILABLE=0

    if [ -r ${OBJECT_FILENAME} ]; then
        CACHED_VERSION_AVAILABLE=1
    fi

    echo ${CACHED_VERSION_AVAILABLE}
}

function cache__delete {
    local OBJECT_NAME=${1}
    local OBJECT_FILENAME="${CACHE_PATH}/${OBJECT_NAME}.cache"

    rm ${OBJECT_FILENAME}
}

function cache__load {
    local OBJECT_NAME=${1}
    local OBJECT_FILENAME="${CACHE_PATH}/${OBJECT_NAME}.cache"

    require_file ${OBJECT_FILENAME}

    cat ${OBJECT_FILENAME}
}


if [ ! -d ${CACHE_PATH} ]; then
    echo "Create cache directory: ${CACHE_PATH}"
    mkdir -p "${CACHE_PATH}"
fi
