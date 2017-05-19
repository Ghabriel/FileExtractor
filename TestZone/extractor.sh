#!/bin/bash

path=$1
filename=$(basename "$path")
extension="${filename#*.}"
filename="${filename%%.*}"

if [ -d "$filename"  ]; then
    echo "Folder '$filename' already exists."
else
    mkdir $filename
    cd $filename
    case "$extension" in
        "tar.gz")
            tar -xvf ../$path
        ;;
        "zip")
            unzip ../$path
        ;;
        *)
            echo "Unsuported file type"
        ;;
    esac

    count=0
    for file in $(ls); do
        count=$[$count+1]
    done

    if [[ $count == 1 && -d "$filename" ]]; then
        mv $filename/* .
        rmdir $filename
    fi
fi
