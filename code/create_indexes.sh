#!/bin/bash

# **************** Global variables
export HOME_PATH=$(pwd)

# IBM Cloud - elastic search variables
source ./.env

# **********************************************************************************
# Functions definition
# **********************************************************************************

function create_index_documents () {
    INDEX_TO_CREATE=documents

    echo "Create: $INDEX_TO_CREATE"
    CURL_CA_BUNDLE=$E_CERT_PATH/$E_CERT_FILE_NAME curl -u ${E_ADMIN_USER}:${E_ADMIN_PASSWORD} -i -XPUT "https://${E_HOST}:${E_PORT}/$INDEX_TO_CREATE?pretty"

}

function create_index_passages () {
    INDEX_TO_CREATE=passages

    echo "Create: $INDEX_TO_CREATE"
    CURL_CA_BUNDLE=$E_CERT_PATH/$E_CERT_FILE_NAME curl -u ${E_ADMIN_USER}:${E_ADMIN_PASSWORD} -i -XPUT "https://${E_HOST}:${E_PORT}/$INDEX_TO_CREATE?pretty"

}

#**********************************************************************************
# Execution
# *********************************************************************************

create_index_documents
create_index_passages

