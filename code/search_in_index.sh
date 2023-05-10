#!/bin/bash

# **************** Global variables
HOME_PATH=$(pwd)

# IBM Cloud - elastic search variables
source ./.env

# **********************************************************************************
# Functions definition
# **********************************************************************************

function query_all_data () {
    CURL_CA_BUNDLE=$E_CERT_PATH/$E_CERT_FILE_NAME curl -u ${E_ADMIN_USER}:${E_ADMIN_PASSWORD} -XGET -H "Content-Type: application/json" "https://${E_HOST}:${E_PORT}/documents/_search" -d '{"query" : {"match_all" : {}}}' | jq '.'
}

function query_sample_data () {
    CURL_CA_BUNDLE=$E_CERT_PATH/$E_CERT_FILE_NAME curl -u ${E_ADMIN_USER}:${E_ADMIN_PASSWORD} -XGET -H "Content-Type: application/json" "https://${E_HOST}:${E_PORT}/documents/_search" -d '{ "query": {"multi_match" : {"query" : "Second Hello World?","fields": ["title", "text"]}}}' | jq '.'
}

#**********************************************************************************
# Execution
# *********************************************************************************

query_data
query_sample_data
