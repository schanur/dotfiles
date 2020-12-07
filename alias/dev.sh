if [ "${SHELL_NAME}" = "zsh" ]; then
    alias reload="source ~/.zshrc  && xrdb ~/.Xresources"
else
    alias reload="source ~/.bashrc && xrdb ~/.Xresources"
fi

# Print backtrace of a crashing application.
alias bt='gdb -batch -ex "break assert" -ex "run" -ex "bt" -ex "quit"'

# less, but with syntax highlighting.
alias lessh='LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s" less -M '


# Preload every application with jemalloc memory allocator.
alias jemalloc-preload="export LD_PRELOAD=$LD_PRELOAD:/usr/lib/x86_64-linux-gnu/libjemalloc.so"
