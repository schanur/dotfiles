#!/bin/bash

# If we have a valid barrier config file available start barrier with
# this config. Do nothing otherwise.


set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/.."

source "${DOTFILES_PATH}/lib/bivalvia/help.sh"


function barrier_is_running {
    local BARRIER_IS_RUNNING=$(ps aux | grep -ce 'barrier.*--disable-crypto --no-daemon' || true)
    (( BARRIER_IS_RUNNING-- ))
    echo ${BARRIER_IS_RUNNING}
}


function start_server {
    touch "/tmp/barrier_server.log"
    barriers --disable-crypto --no-daemon --debug DEBUG --log /tmp/barrier_server.log --name server --address :: --config "${DOTFILES_PATH}/barrier/server.conf"
}


function start_client {
    touch "/tmp/barrier_client.log"
    # Even activating IPv6 avahi did not macke "[]:24800" autoconfig work.
    barrierc --disable-crypto --no-daemon --debug DEBUG --log /tmp/barrier_client.log --name client1 "[mizar.local]:24800"
}


if [ $(barrier_is_running) -eq 1 ]; then
    echo "Barrier is already running. Do nothing."
    exit 0
fi


if [ "$(cat /etc/machine-id | sha512sum | cut -f 1 -d ' ')" = "56314343caf6ab223f04b7261f6d8cc5732aaacffdf04a66d420069f9a77e4e6c3e231b45bea4338a190b477e552ffdc874e9b5b699d6c2258fb51848d3535f3" ]; then
    echo "Start barrier server."
    start_server
else
    echo "Start barrier client."
    start_client
fi
