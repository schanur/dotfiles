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
    barriers --disable-crypto --no-daemon --debug DEBUG --log /tmp/barrier_server.log --name "$(hostname)" --address :: --config "${DOTFILES_PATH}/barrier/server.conf"
}


function start_client {
    touch "/tmp/barrier_client.log"
    # Even activating IPv6 avahi did not make "[]:24800" autoconfig work.
    barrierc --disable-crypto --no-daemon --debug DEBUG --log /tmp/barrier_client.log --name "$(hostname)" "[alkaid]:24800"
}


if [ $(barrier_is_running) -eq 1 ]; then
    echo "Barrier is already running. Do nothing."
    exit 0
fi


if [ "$(cat /etc/machine-id | sha512sum | cut -f 1 -d ' ')" = "d1b9443b8608ab188b6a1d21855b6805648bb26340561b79d31c9c5c9a11582131df067895c20cd136d8a7adfba2071af665c04d1ce8b70e35b70fdc6a0d89e6" ]; then
    echo "Start barrier server."
    start_server
else
    echo "Start barrier client."
    start_client
fi
