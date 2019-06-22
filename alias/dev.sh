if [ "${SHELL_NAME}" = "zsh" ]; then
    alias reload="source ~/.zshrc  && xrdb ~/.Xresources"
else
    alias reload="source ~/.bashrc && xrdb ~/.Xresources"
fi

# Print backtrace of a crashing application.
alias bt='gdb -batch -ex "run" -ex "bt" -ex "quit"'
