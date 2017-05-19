#!/bin/bash

path=$1
filename=$(basename "$path")

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

if check ".tar.gz"; then
    tar -xvf ../$path
elif check ".zip"; then
    unzip ../$path
else
    echo "Unknown file type"
    exit 1
fi

count=0
for file in $(ls); do
    count=$[$count+1]
done

if [[ $count == 1 && -d "$filename" ]]; then
    mv $filename/* .
    rmdir $filename
fi
