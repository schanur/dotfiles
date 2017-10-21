#!/bin/bash


set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/.."


# notify-send "test"


function current_volume {
    amixer get 'Master' |grep 'Front Left:' | cut -f 2 -d '[' | cut -f 1 -d ']'
}

case ${1} in

    AudioRaiseVolume)
        amixer -q sset Master 3%+
        notify-send "Increase volume: $(current_volume)"
        ;;
    AudioLowerVolume)
        amixer -q sset Master 3%-
        notify-send "Decrease volume: $(current_volume)"
        ;;
    AudioMute)
        notify-send -u critical "Not implemented"
        ;;

    MonBrightnessUp)
        # exec xbacklight -inc 20
        notify-send -u critical "Not implemented"
        ;;
    MonBrightnessDown)
        # exec xbacklight -dec 20
        notify-send -u critical "Not implemented"
        ;;

    TouchpadToggle)
        if synclient -l | grep "TouchpadOff .*=.*0" ; then
            synclient TouchpadOff=1 ;
            notify-send "Touchpad disabled"
        else
            synclient TouchpadOff=0 ;
            notify-send "Touchpad enabled"
        fi
        ;;

    *)
        notify-send -u critical "Invalid command: ${1}"
        ;;

esac
