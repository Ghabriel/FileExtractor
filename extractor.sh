#!/bin/bash

ROOT_FOLDER=$(dirname $(readlink -f "$0"))
CONFIG_FILENAME=$ROOT_FOLDER/config.sh

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
    # TODO: replace $(pwd) with something less verbose
    echo "Extracting \"$1\" into $(pwd)"

    BUNDLE_FILENAME="$ROOT_FOLDER/$1"
    source $CONFIG_FILENAME > /dev/null
}

function check() {
    testedExtension=$1
    length=${#testedExtension}
    filenameEnd=${filename:(-$length):$length}
    if [[ "$testedExtension" == "$filenameEnd" ]]; then
        return 0
    else
        return 1
    fi
}

readInputArguments "$@"
NUM_INPUT_FILES=`echo "$INPUT_FILES" | wc -l`

if [[ "$NUM_INPUT_FILES" == "1" ]]; then
    if [[ "$TARGET_FOLDER" == "" ]]; then
        # TODO: remove this hardcoded extension
        getBaseName "$INPUT_FILES" "zip"
        TARGET_FOLDER=$RETURNED_VALUE
    fi

    if [[ -d "$TARGET_FOLDER" ]]; then
        echo >&2 "Folder '$TARGET_FOLDER' already exists."
        exit 1
    fi

    mkdir $TARGET_FOLDER
    cd $TARGET_FOLDER
    extract "$INPUT_FILES"
else
    if [[ "$TARGET_FOLDER" == "" ]]; then
        echo >&2 "Specifying more than one input file requires a target name."
        exit 1
    fi

    if [[ -d "$TARGET_FOLDER" ]]; then
        echo >&2 "Folder '$TARGET_FOLDER' already exists."
        exit 1
    fi

    mkdir $TARGET_FOLDER
    cd $TARGET_FOLDER

    while read -r file; do
        # TODO: remove this hardcoded extension
        getBaseName "$file" "zip"
        SUB_FOLDER=$RETURNED_VALUE

        if [[ -d "$SUB_FOLDER" ]]; then
            # TODO: is skipping this file a good idea?
            echo >&2 "Skipping file '$file' due to conflicting input filenames: duplicate target folder '$SUB_FOLDER'."
            continue
        fi

        mkdir $SUB_FOLDER
        cd $SUB_FOLDER
        extract "$file"
        cd ..
    done <<< "$INPUT_FILES"
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
