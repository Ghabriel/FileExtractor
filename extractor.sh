#!/bin/bash

INPUT_FILES=""
TARGET_FILE=""

function readInputArguments() {
    while test $# -gt 0; do
        if [[ $1 == -* ]]; then
            break
        fi

        INPUT_FILES="$INPUT_FILES $1"
        shift
    done

    while getopts "o:x" opt; do
        case $opt in
        o)
            TARGET_FILE="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            exit 1
            ;;
        esac
    done

    shift $(expr $OPTIND - 1 )

    while test $# -gt 0; do
        INPUT_FILES="$INPUT_FILES $1"
        shift
    done
}

readInputArguments $@
echo "Input files: $INPUT_FILES"
echo "Output file: $TARGET_FILE"

for file in $INPUT_FILES; do
    echo "Input: $file"
done

FILE_COUNT=`echo $INPUT_FILES | wc -w`
echo "Number of files: $FILE_COUNT"

# path=$1
# filename=$(basename "$path")
# explicit_name=0

# if [[ $# -ge 2 ]]; then
#     explicit_name=1
#     folder_name=$2
# fi

# function check() {
#     extension=$1
#     length=${#extension}
#     end=${filename:(-$length):$length}
#     if [[ "$extension" == "$end" ]]; then
#         filename=${filename:0:(-$length)}
#         if [[ $explicit_name -eq 1 ]]; then
#             folder=$folder_name
#         else
#             folder=$filename
#         fi

#         if [[ -d "$folder" ]]; then
#             echo >&2 "Folder '$folder' already exists."
#             exit 1
#         else
#             mkdir $folder
#             cd $folder
#         fi
#         return 0
#     else
#         return 1
#     fi
# }

# source $(dirname $(readlink -f "$0"))/config.sh

# count=0
# for file in $(ls); do
#     count=$[$count+1]
# done

# cd ..

# if [[ $count == 1 ]]; then
#     mv $folder/$file/* $folder/
#     rmdir $folder/$file
# fi
