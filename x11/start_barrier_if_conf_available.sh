#!/bin/bash

# If we have a valid barrier config file available start barrier with
# this config. Do nothing otherwise.


set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/.."

source "${DOTFILES_PATH}/lib/bivalvia/help.sh"


function start_server {
    barriers --debug INFO --log /tmp/barrier_server.log --name server --config "${DOTFILES_PATH}/barrier/server.conf"
    # barrier --debug INFO --log /tmp/barrier_server.log --name server --config "${DOTFILES_PATH}/barrier/server.conf"
}


function start_client {
    # barrierc --debug INFO --log /tmp/barrier_client.log --name client1 --config "${DOTFILES_PATH}/barrier/client.conf"
    barrierc --debug INFO --log /tmp/barrier_client.log --name client1 "$BARRIER_SERVER"
}

if [ "$(cat /etc/machine-id | sha512sum | cut -f 1 -d ' ')" = "56314343caf6ab223f04b7261f6d8cc5732aaacffdf04a66d420069f9a77e4e6c3e231b45bea4338a190b477e552ffdc874e9b5b699d6c2258fb51848d3535f3" ]; then
    echo "Start barrier server."
    start_server
else
    echo "Start barrier client."
    start_client
fi
