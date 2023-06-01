#!/bin/bash

# **************** Global variables
export HOME_PATH=$(pwd)

# IBM Cloud - elastic search variables
source ./.env

# **********************************************************************************
# Functions definition
# **********************************************************************************

function query_all_data () {
    curl -XGET -H "Content-Type: application/json" "http://${E_HOST}:${E_PORT}/documents/_search" -d '{"query" : {"match_all" : {}}}' | jq '.'
}

function query_sample_data () {
    curl -XGET -H "Content-Type: application/json" "http://${E_HOST}:${E_PORT}/documents/_search" -d '{ "query": {"multi_match" : {"query" : "Second Hello World?","fields": ["title", "text"]}}}' | jq '.'
}

#**********************************************************************************
# Execution
# *********************************************************************************

query_all_data
query_sample_data
