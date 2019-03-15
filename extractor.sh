#!/bin/bash

INPUT_FILES=""
TARGET_FOLDER=""

RETURNED_VALUE=""

function readInputArguments() {
    while test $# -gt 0; do
        if [[ "$1" == -* ]]; then
            break
        fi

        INPUT_FILES="$INPUT_FILES\n$1"
        shift
    done

    while getopts "o:x" opt; do
        case $opt in
        o)
            TARGET_FOLDER="$OPTARG"
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
        INPUT_FILES="$INPUT_FILES\n$1"
        shift
    done

    INPUT_FILES=$(echo -e "${INPUT_FILES:2:${#INPUT_FILES}}");
}

# Returns the name of a file, discarding folder names and extension
# Parameters:
# $1 - filename
# $2 - extension
function getBaseName() {
    filename=$1
    extension=$2
    length=${#extension}

    RETURNED_VALUE=$(basename -- "${filename:0:(-1-$length)}")
}

function extract() {
    echo "Extracting "$1" into $(pwd)"
}

readInputArguments "$@"
NUM_INPUT_FILES=`echo "$INPUT_FILES" | wc -l`

if [[ "$NUM_INPUT_FILES" == "1" ]]; then
    if [[ "$TARGET_FOLDER" == "" ]]; then
        # TODO: remove this hardcoded extension
        getBaseName "$INPUT_FILES" "zip"
        TARGET_FOLDER=$RETURNED_VALUE
    fi

    echo "Input: $INPUT_FILES"
    echo "Target folder name: $TARGET_FOLDER"

    if [[ -d "$TARGET_FOLDER" ]]; then
        echo >&2 "Folder '$TARGET_FOLDER' already exists."
        exit 1
    fi

    mkdir $TARGET_FOLDER
    cd $TARGET_FOLDER
    extract $INPUT_FILES
else
    echo "More than one input file."
fi

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
