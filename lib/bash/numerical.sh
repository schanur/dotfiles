
function is_number {
    local IS_NUMBER=0

    case ${VARIABLE} in
        ''|*[!0-9]*)
            IS_NUMBER=1
            ;;
    esac

    echo ${IS_NUMBER}
}
