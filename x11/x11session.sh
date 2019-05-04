

# unclutter -idle 2 &
redshift &

# IBM Model M does not have a Super(Win) key. Use CAPS Lock instead.
setxkbmap -option caps:super

# Set background color.
xsetroot -solid darkred


echo "$(date -Iseconds): shared/x11session: $0" >> "${HOME}/user.log"

export CONF_FILE_LOADED__X11SESSION=1
