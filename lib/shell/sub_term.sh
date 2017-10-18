function run_in_sub_terminal {
    local PARAMETER="$*"
    if [ -v ${DOTFILES__IS_SUB_TERMINAL} ]; then
        export DOTFILES__IS_SUB_TERMINAL=1
        xterm "${SCRIPT_FILENAME}" ${PARAMETER}
        exit
    fi
}
