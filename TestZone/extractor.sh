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
    echo "Filename: $filename"
    echo "Extension: $extension"
	case "$extension" in
		"tar.gz")
			tar -xvf $path
		;;
		"zip")
			unzip $path
	esac
fi

