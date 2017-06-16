#!/bin/bash

set -o errexit -o nounset -o pipefail
SCRIPT_FILENAME="$(readlink -f "${0}")"
SCRIPT_PATH="$(dirname "${SCRIPT_FILENAME}")"
DOTFILES_PATH="${SCRIPT_PATH}/../.."


# Read n bytes from /dev/urandom and covert it to a decimal string
# representation. Valid input is 1, 2, 4, 8.
function random_n_byte_as_decimal {
    local BYTES=${1}
    od -v -An -N${BYTES} -tu${BYTES} < /dev/urandom |sed -e 's/\ //g'
}

function random_8_bit_decimal {
    random_n_byte_as_decimal 1
}

function random_32_bit_decimal {
    random_n_byte_as_decimal 4
}

function test_mod_200 {
    for ((I=0;I<5000;I++)); do
        RAND_N=$(random_8_bit_decimal)
        A=$((RAND_N % 200))
        echo $A
    done
}

function test_mod_128 {
    for ((I=0;I<5000;I++)); do
        RAND_N=$(random_8_bit_decimal)
        A=$((RAND_N % 200))
        echo $A
    done
}


function test_equal_distribution {
    local RAND_MAX=$1
    for ((I=0;I<5000;I++)); do
        random $RAND_MAX
    done
}

test_mod_200                |sort |uniq -c |awk '{ print $2 " " $1}' |sort -n
echo --------------------------------------------------------------
test_mod_128                |sort |uniq -c |awk '{ print $2 " " $1}' |sort -n
echo --------------------------------------------------------------
test_equal_distribution 200 |sort |uniq -c |awk '{ print $2 " " $1}' |sort -n
