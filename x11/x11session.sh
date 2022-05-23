
. .config/dotfiles/basepath/x11/gui_toolkit_colors.sh


# unclutter -idle 2 &
redshift &

# IBM Model M does not have a Super(Win) key. Use CAPS Lock instead.
# setxkbmap -option caps:super

# Set background color.
# xsetroot -solid darkred

# Set background image.

.config/dotfiles/basepath/scripts-extra/desktop/set-background .config/dotfiles/basepath/background_image/algo_generated/ulam_spiral_480x270.png &

# 480x270
# 960x540

echo "$(date -Iseconds): shared/x11session: $0" >> "${HOME}/user.log"

export CONF_FILE_LOADED__X11SESSION=1
