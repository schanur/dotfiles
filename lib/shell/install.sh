source "${DOTFILES_PATH}/lib/bivalvia/require.sh"
source "${DOTFILES_PATH}/lib/bivalvia/link.sh"


function init_and_update_submodules() {
    git submodule init
    git submodule update
}


function init_install_dependencies() {
    init_and_update_submodules
}


# Some configuration files require a path without variables or
# absolute path. To fulfill that requirement this function creates a
# symbolic link (if it does not already exists) to this repository
# base path at "${HOME}/.config/dotfiles/basepath".
function link_dotfiles_path_in_user_config {
    local LINK_FILENAME_RELATIVE_TO_HOME=".config/dotfiles/basepath"
    local DOTFILES_FILENAME="${DOTFILES_PATH}"

    backup_user_config_and_create_dotfiles_link "${DOTFILES_FILENAME}" "${LINK_FILENAME_RELATIVE_TO_HOME}"
}


link_dotfiles_path_in_user_config
init_install_dependencies
