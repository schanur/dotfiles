
function stack_trace {
    local I
    local STACK_SIZE=${#FUNCNAME[1]}

    for (( I=1; I < ${STACK_SIZE}; I++ )); do
	local FUNC=${FUNCNAME[${I}]}
	[ x$FUNC = x ] && func=MAIN
	local LINE_NO="${BASH_LINENO[(( I - 1 ))]}"
	local SRC="${BASH_SOURCE[${I}]}"
	[ x"$SRC" = x ] && SRC=NO_FILE_SOURCE

	echo ${FUNC} ${SRC} ${LINE_NO}
    done
}
