#!/bin/bash


set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/.."


# notify-send "test"


function current_volume {
    amixer get 'Master' |grep 'Front Left:' | cut -f 2 -d '[' | cut -f 1 -d ']'
}


function current_brightness {
    xrandr --verbose | grep 'Brightness' | cut -f 2 -d ' ' | head -n 1
}


# function current_brightness_percentage {
#     local BRIGHTNESS=""
#     local BRIGHTNESS_PERCENTAGE=""

#     BRIGHTNESS="$(current_brightness)"
#     notify-send "Debug: ${BRIGHTNESS} | ${BRIGHTNESS_PERCENTAGE}"
#     echo "${BRIGHTNESS} * 100" | bc
#     # BRIGHTNESS_PERCENTAGE=$(( BRIGHTNESS * 100 ))
#     # notify-send "Debug: ${BRIGHTNESS} | ${BRIGHTNESS_PERCENTAGE}"
#     # notify-send "a"

#     echo "${BRIGHTNESS_PERCENTAGE}"
# }


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
        BRIGHTNESS=$(current_brightness)
        NEW_BRIGHTNESS="$(echo "${BRIGHTNESS}" + 0.2 | bc)"
        # if [ ${NEW_BRIGHTNESS} -lt 0 ]; then
        #     NEW_BRIGHTNESS=0
        # fi
        # xrandr --output eDP-1 --brightness "0.${NEW_BRIGHTNESS}"
        notify-send "Increase monitor brightness volume: ${NEW_BRIGHTNESS}"
        xrandr --output eDP-1 --brightness "${NEW_BRIGHTNESS}"
        ;;

    MonBrightnessDown)
        # notify-send "test"
        # # exec xbacklight -dec 20
        BRIGHTNESS=$(current_brightness)
        NEW_BRIGHTNESS="$(echo "${BRIGHTNESS}" - 0.2 | bc)"
        # NEW_BRIGHTNESS=0
        # (( NEW_BRIGHTNESS = BRIGHTNESS + 10 ))
        # if [ ${NEW_BRIGHTNESS} -gt 100 ]; then
        #     NEW_BRIGHTNESS=100
        # fi
        notify-send "Decrease monitor brightness: ${NEW_BRIGHTNESS}"
        xrandr --output eDP-1 --brightness "${NEW_BRIGHTNESS}"
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
