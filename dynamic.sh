#!/bin/bash

path=$1
filename=$(basename "$path")
extension=".tar.gz"

function check_compatibility() {
    length=${#extension}
    end=${filename:(-$length):$length}
    if [[ "$extension" == "$end" ]]; then
        filename=${filename:0:(-$length)}
        return 1
    else
        return 0
    fi
}

check_compatibility
result=$?
echo "Filename: $filename"
echo "Extension: $extension"
echo "Result: $result"
