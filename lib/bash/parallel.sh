
function find_parallel_tool {
    local XJOBS_EXECUTABLE_FOUND=1

    GL_PARALLEL_TOOL_FUNC="run_non_parallel"

    which xjobs > /dev/null 2>/dev/null || XJOBS_EXECUTABLE_FOUND=0

    if [ ${XJOBS_EXECUTABLE_FOUND} -eq 1 ]; then
        GL_PARALLEL_TOOL_FUNC="parallel_xjobs"
    fi
}

function run_non_parallel {
    while read CMD; do
        printf "${CMD}"
    done
}

function parallel_xjobs {
    while read CMD; do
        printf "${CMD}"
    done
}

function parallel_gnu_parallel {
    echo "Not implemented"
    exit 2
}

function parallel_init {
    GL_CPU_CORE_COUNT=$(cat /proc/cpuinfo |grep processor |wc -l)
    find_parallel_tool
}

function parallel_exec {
    cat | GL_PARALLEL_TOOL_FUNC
}

parallel_init
