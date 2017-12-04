function init_and_update_submodules() {
    git submodule init
    git submodule update
}

function init_install_dependencies() {
    init_and_update_submodules
}

init_install_dependencies
