#!/bin/bash

# **************** Global variables
HOME_PATH=$(pwd)

# IBM Cloud - elastic search variables
source ./.env

# **********************************************************************************
# Functions definition
# **********************************************************************************

function upload_index_passages () {
    cd $HOME_PATH
    echo "Path: $(pwd)"
    while IFS= read -r file ; do
        echo "Upload next file: $file"
        #cat "$file" | jq -c '.[] | {"index": {"_index": "passages", "_id": .url}}, .' | CURL_CA_BUNDLE=$E_CERT_PATH/$E_CERT_FILE_NAME curl -u ${E_ADMIN_USER}:${E_ADMIN_PASSWORD} -i -XPOST -H "Content-Type: application/json" "https://${E_HOST}:${E_PORT}/_bulk" --data-binary @-
    done < $(find . -name '*.json' 2>/dev/null | sed -r -e 's/([0-9]+)/ \1/' | sort -k 2 -n | sed -e 's/ //;')
}

function upload_index_documents () {
    cd $HOME_PATH/../result-full
    echo "Path: $(pwd)"
    while IFS= read -r file ; do
        echo "Upload next file: $file"
        #cat "$file" | jq -c '.[] | {"index": {"_index": "documents", "_id": .url}}, .' | CURL_CA_BUNDLE=$E_CERT_PATH/$E_CERT_FILE_NAME curl -u ${E_ADMIN_USER}:${E_ADMIN_PASSWORD} -i -XPOST -H "Content-Type: application/json" "https://${E_HOST}:${E_PORT}/_bulk" --data-binary @-
    done < $(find . -name '*.json' 2>/dev/null | sed -r -e 's/([0-9]+)/ \1/' | sort -k 2 -n | sed -e 's/ //;')
    cd $HOME_PATH
}

#**********************************************************************************
# Execution
# *********************************************************************************

upload_index_passages
upload_index_documents
