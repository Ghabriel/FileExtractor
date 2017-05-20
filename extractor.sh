#!/bin/bash

path=$1
filename=$(basename "$path")
script_dir=$(dirname $(readlink -f "$0"))

function check() {
    extension=$1
    length=${#extension}
    end=${filename:(-$length):$length}
    if [[ "$extension" == "$end" ]]; then
        filename=${filename:0:(-$length)}
        if [[ -d "$filename" ]]; then
            echo >&2 "Folder '$filename' already exists."
            exit 1
        else
            mkdir $filename
            cd $filename
        fi
        return 0
    else
        return 1
    fi
}

source $script_dir/config.sh

count=0
for file in $(ls); do
    count=$[$count+1]
done

cd ..

if [[ $count == 1 ]]; then
    mv $filename/$file/* $filename/
    rmdir $filename/$file
fi
