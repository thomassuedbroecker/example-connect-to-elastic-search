#!/bin/bash

# **************** Global variables
export HOME_PATH=$(pwd)

# IBM Cloud - elastic search variables
source ./.env

# **********************************************************************************
# Functions definition
# **********************************************************************************

function upload_index_passages () {
    cd $HOME_PATH/split
    INDEX=passages
    directory="$(pwd)"
    array=()

    for file_name in $directory/*.json; do
        if [ -f "$file_name" ]; then
            data=$(echo $file_name | sed -r -e 's/([0-9]+)/ \1/' | sort -k 2 -n | sed -e 's/ //;')
            array+=("$data")
        fi
    done

    for file in "${array[@]}";do
       echo "Upload next file: $file"
       cat $file
       cat "$file" | jq -c '.[] | {"index": {"_index": "passages", "_id": .url}}, .' | curl -i -XPOST -H "Content-Type: application/json" "http://${E_HOST}:${E_PORT}/_bulk" --data-binary @-
    done
}

function upload_index_documents () {
    
    cd $HOME_PATH/full
    directory="$(pwd)"
    INDEX=documents
    array=()
    for file_name in $directory/*.json; do
        if [ -f "$file_name" ]; then
            data=$(echo $file_name | sed -r -e 's/([0-9]+)/ \1/' | sort -k 2 -n | sed -e 's/ //;')
            array+=("$data")
        fi
    done

    for file in "${array[@]}";do
       echo "Upload next file: $file"
       cat $file
       cat "$file" | jq -c '.[] | {"index": {"_index": "documents", "_id": .url}}, .' | curl -i -XPOST -H "Content-Type: application/json" "http://${E_HOST}:${E_PORT}/_bulk" --data-binary @-
    done

    cd $HOME_PATH
}

#**********************************************************************************
# Execution
# *********************************************************************************

upload_index_passages
upload_index_documents
