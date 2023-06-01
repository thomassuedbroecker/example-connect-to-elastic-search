#!/bin/bash

# **************** Global variables
export HOME_PATH=$(pwd)

# IBM Cloud - elastic search variables
source ./.env

# **********************************************************************************
# Functions definition
# **********************************************************************************

function delete_index_passages () {
    INDEX_TO_DELETE=passages

    echo "Delete: $INDEX_TO_DELETE"
    curl -i -XDELETE "http://${E_HOST}:${E_PORT}/$INDEX_TO_DELETE?pretty"
}

function delete_index_documents () {
    INDEX_TO_DELETE=documents

    echo "Delete: $INDEX_TO_DELETE"
    curl -i -XDELETE "http://${E_HOST}:${E_PORT}/$INDEX_TO_DELETE?pretty"
}

#**********************************************************************************
# Execution
# *********************************************************************************

delete_index_passages
delete_index_documents
