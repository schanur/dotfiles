
# SCRIPT_FILENAME=$(readlink -f $0)
# SCRIPT_PATH=$(dirname $SCRIPT_FILENAME)
# DOTFILES_PATH=${SCRIPT_PATH}/..


for INC_FILE in $(find ${DOTFILES_PATH}/alias |grep -v "all.sh"); do
    # echo "Load alias file: ${INC_FILE}"
    if [ ! -d ${INC_FILE} ]; then
        echo -n " $(basename -s .sh ${INC_FILE})"
        . ${INC_FILE}
    fi
done
