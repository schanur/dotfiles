if [ "${SHELL_NAME}" = "zsh" ]; then
    alias reload="source ~/.zshrc  && xrdb ~/.Xresources"
else
    alias reload="source ~/.bashrc && xrdb ~/.Xresources"
fi
