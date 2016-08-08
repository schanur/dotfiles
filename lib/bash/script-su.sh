
function run_as_root {
    if [ "${USER}" != "root" ]; then
        echo "Root privileges are required.
Please enter root password to continue or CTRL+C to abort."
        su -c "${0} ${*}" root
        exit
    fi
}
