
function fill_tail {
    local STRING=${1}
    local LENGTH=${2}
    local FILL_CHARACTER=${3}
    local FILL_CHARACTER_COUNT

    (( FILL_CHARACTER_COUNT=${LENGTH}-${#STRING} ))
    # echo ${FILL_CHARACTER_COUNT}
    for I in $(seq 1 ${FILL_CHARACTER_COUNT}); do
        STRING="${STRING}${FILL_CHARACTER}"
    done

    echo "${STRING}"
}
