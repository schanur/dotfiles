echo "------------------------------------------------------------------------"
echo "sharedrc:"
echo

echo "SHELL_NAME: ${SHELL_NAME}"

BIVALVIA_PATH="${DOTFILES_PATH}/lib/bivalvia"

echo
echo "Set PATH:"

source ${DOTFILES_PATH}/shared/colorized_man_pages.sh
echo -n "Load alias files:"
source ${DOTFILES_PATH}/alias/all.sh
echo

CD_PATH_LIST=".:${HOME}:${HOME}/local:${HOME}/local/dev:${HOME}/local/dev/all:$HOME/.cargo/bin"

# If user defined additional directories to add to CD_PATH, use them too.
EXTRA_CD_PATH_FILE="${HOME}/.config/dotfiles/cdpath"
if [ -r ${EXTRA_CD_PATH_FILE} ]; then
    for EXTRA_CD_PATH in $(cat ${EXTRA_CD_PATH_FILE}); do
        CD_PATH_LIST="${CD_PATH_LIST}:${EXTRA_CD_PATH}"
    done
fi
echo "CD_PATH_LIST: ${CD_PATH_LIST}"

# Add all paths in a file to the PATH variable. Prints a warning if a
# path is tried to get added a second time.
function load_exectuable_path_file {
    local EXECUTABLE_PATH_FILENAME="${1}"

    if [ -f "${EXECUTABLE_PATH_FILENAME}" ]; then
        # echo $(cat "${EXECUTABLE_PATH_FILENAME}")
        for EXECUTABLE_PATH in $(cat "${EXECUTABLE_PATH_FILENAME}"); do
        if [ "${EXECUTABLE_PATH}" != "." ]; then
            ABSOLUTE_EXECUTABLE_PATH="$(dirname ${EXECUTABLE_PATH_FILENAME})/${EXECUTABLE_PATH}"
        else
            ABSOLUTE_EXECUTABLE_PATH="$(dirname ${EXECUTABLE_PATH_FILENAME})"
        fi
        # echo "EXECUTABLE_PATH: ${EXECUTABLE_PATH_FILENAME}: ${ABSOLUTE_EXECUTABLE_PATH}"
        echo "  Add:  ${EXECUTABLE_PATH_FILENAME} -> ${ABSOLUTE_EXECUTABLE_PATH}"
        export PATH="${PATH}:${ABSOLUTE_EXECUTABLE_PATH}"
        done
    fi
}

export PATH="${PATH}:${HOME}/.cargo/bin:${HOME}/.local/bin/"
echo ".executable_path files: "
for REPO_PATH in $("${DOTFILES_PATH}/scripts-extra/development/git-list"); do
    # echo $REPO_PATH
    if [              "${REPO_PATH}" = ""         ]; then echo "  Ignore empty list entry.";                 continue; fi # Can happen if "git-list" returned empty list.
    if [ $(basename "${REPO_PATH}")  = "dotfiles" ]; then echo "  Skip: ${REPO_PATH}. It gets loaded later."; continue; fi

    REPO_EXECUTABLE_PATH_FILENAME="${REPO_PATH}/.executable_path"
    load_exectuable_path_file "${REPO_EXECUTABLE_PATH_FILENAME}"
done

load_exectuable_path_file "${DOTFILES_PATH}/.executable_path"


case ${SHELL_NAME} in
    bash)
        CDPATH=${CD_PATH_LIST}
        ;;
    zsh)
        CDPATH=${CD_PATH_LIST}
        # cdpath=${CD_PATH_LIST}
        ;;
esac
echo
echo "Final CDPATH:"
echo ${CDPATH}

source ${DOTFILES_PATH}/vendor/shell-status-prompt/shell-status-prompt.sh

export NUMCPUS=$(grep -c '^processor' /proc/cpuinfo)
export MAKEFLAGS="-j $(( NUMCPUS * 2 ))"

# Set 'ls' directory color to purple
# LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
LS_COLORS=$LS_COLORS:'di=0;96:' ; export LS_COLORS

# echo "------------------------------------------------------------------------"

# echo "SHELL_NAME:         ${SHELL_NAME}"
# echo "DOTFILES_PATH:      ${DOTFILES_PATH}"
# echo "BIVALVIA_PATH:      ${BIVALVIA_PATH}"
# echo "CDPATH:             ${CDPATH}"
# echo "NUMCPUS:            ${NUMCPUS}"
# echo "MAKEFLAGS:          ${MAKEFLAGS}"
# echo "CD_PATH_LIST:       ${CD_PATH_LIST}"
# echo "EXTRA_CD_PATH_FILE: ${EXTRA_CD_PATH_FILE}"

echo "------------------------------------------------------------------------"

echo -ne "date:\n  "
date

#echo -e "\ngroups:"
#for ITEM in `id |awk '{print $3}' |sed -e 's/groups=//g' |sed -e 's/,/ /g'`; do
#    echo "  `echo $ITEM |sed -e 's/(/ (/g'`"
#done

# TODO: Sort by date before selecting the top 5.
echo -e "\nlast logins:"
local LOGIN_LINE=""
while read LOGIN_LINE; do
    echo "  $LOGIN_LINE"
done <<< "`lastlog | grep -v --color=never "**Never logged in**" | head -n 5`"

echo -ne "\nmachine:\n  "
hostname

echo -ne "\nnetwork devices:\n "
local NETWORK_DEVICE=""
for NETWORK_DEVICE in `cat /proc/net/dev |grep : |sed -e 's/:.*//g' |sed -e 's/\ *//g'`; do
    echo -n " $NETWORK_DEVICE"
done
echo
echo

#echo -ne "\nopen connections:\n"
#local CONNECTION=""
#while read CONNECTION; do
#    echo "  $CONNECTION"
#done <<< "`netstat -n |grep ESTABLISHED |sed -e 's/ESTABLISHED//g' |sed -e 's/\ \ /\ /g'`"

# free
# last
# lastb

echo -n "Alias of the day: "
alias-of-the-day

# We do not want to pollute the namespace of each shell. Delete all
# functions defined in this module.
unset -f load_exectuable_path_file


export CONF_FILE_LOADED__SHELLRC=1
