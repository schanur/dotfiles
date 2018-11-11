#!/bin/bash


set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/../.."


BACKGROUND_IMAGE_FILENAME="${DOTFILES_PATH}/background_image/algo_generated/ulam_spiral_480x270.png"


"${DOTFILES_PATH}/scripts-extra/desktop/set-background" "${BACKGROUND_IMAGE_FILENAME}"
