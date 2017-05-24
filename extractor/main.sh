#!/bin/bash

path=$1
filename=$(basename "$path")
explicit_name=0

if [[ $# -ge 2 ]]; then
    explicit_name=1
    folder_name=$2
fi

function check() {
    extension=$1
    length=${#extension}
    end=${filename:(-$length):$length}
    if [[ "$extension" == "$end" ]]; then
        filename=${filename:0:(-$length)}
        if [[ $explicit_name -eq 1 ]]; then
            folder=$folder_name
        else
            folder=$filename
        fi

        if [[ -d "$folder" ]]; then
            echo >&2 "Folder '$folder' already exists."
            exit 1
        else
            mkdir $folder
            cd $folder
        fi
        return 0
    else
        return 1
    fi
}

source $(dirname $(readlink -f "$0"))/config.sh

count=0
for file in $(ls); do
    count=$[$count+1]
done

cd ..

if [[ $count == 1 ]]; then
    mv $folder/$file/* $folder/
    rmdir $folder/$file
fi
