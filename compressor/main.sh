#!/bin/bash

extension_ok=0
explicit_output=0
output="compressed"

if [[ $# -le 2 ]]; then
	echo >&2 "what"
fi

if [[ $1 != "-o" ]]; then
	extension_ok=1
	extension="$1"
	shift
fi

if [[ $1 == "-o" ]]; then
	shift
	explicit_output=1
	output=$1
	shift
	if [[ $extension_ok -eq 0 ]]; then
		extension="$1"
		shift
	fi
fi

extension=".$extension"
length=${#extension}
end=${output:(-$length):$length}
if [[ "$extension" != "$end" ]]; then
	output+="$extension"
fi

files=$@

function check() {
    if [[ "$extension" == "$1" ]]; then
        return 0
    else
        return 1
    fi
}

source $(dirname $(readlink -f "$0"))/config.sh
