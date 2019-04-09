# Run all scrips that start with a number between 00 and 99 in
# ascending order. Scripts with same number are allowed to be run
# parallel. Implementation with serial execution of scripts with same
# number is still a valid implementation.
function run_scripts_in_path_ordered {
    local SCRIPT_FILENAME
    find -regex "[0-9][0-9]*" | sort | while [ read -r SCRIPT_FILENAME ]; do
        "${SCRIPT_FILENAME}"
    done
}
