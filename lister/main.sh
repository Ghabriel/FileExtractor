#!/bin/bash

path=$1
filename=$(basename "$path")

function check() {
    extension=$1
    length=${#extension}
    end=${filename:(-$length):$length}
    if [[ "$extension" == "$end" ]]; then
        return 0
    else
        return 1
    fi
}

source $(dirname $(readlink -f "$0"))/config.sh
