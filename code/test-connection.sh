#!/bin/bash

# **************** Global variables
HOME_PATH=$(pwd)

# IBM Cloud - elastic search variables
source ./.env

# **********************************************************************************
# Functions definition
# **********************************************************************************

function test_connection () {
    echo "Basic CURL command:"
    curl --cacert $E_CERT_PATH/$E_CERT_FILE_NAME $ELASTIC_URL
    echo "CURL from documentation: https://cloud.ibm.com/docs/databases-for-elasticsearch?topic=databases-for-elasticsearch-connecting-curl"
    CURL_CA_BUNDLE=$E_CERT_PATH/$E_CERT_FILE_NAME curl -u ${E_ADMIN_USER}:${E_ADMIN_PASSWORD} "https://${E_HOST}:${E_PORT}/_cluster/health?pretty"#
}

#**********************************************************************************
# Execution
# *********************************************************************************

test_connection

