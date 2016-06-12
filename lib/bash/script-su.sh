
function run_as_root {
    if [ "${USER}" != "root" ]; then
        su -c "${0}" root
        exit
    fi
}
