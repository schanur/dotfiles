
function stack_trace {
    local I

    echo
    echo "Stack trace:"
    for (( I=0; I < 100; I++ )); do
        # FIXME: -v is not very portable.
        if [[ ! -v FUNCNAME[${I}] ]]; then
            break
        fi
        local FUNC=${FUNCNAME[${I}]}
        [ x$FUNC = x ] && func=MAIN
        local LINE_NO="${BASH_LINENO[(( I - 1 ))]}"
        local SRC="${BASH_SOURCE[${I}]}"
        [ x"$SRC" = x ] && SRC=NO_FILE_SOURCE

        echo ${I} ${FUNC} ${SRC} ${LINE_NO} >&2
    done
}

function dbg_msg {
    echo "${*}" >&2
}
