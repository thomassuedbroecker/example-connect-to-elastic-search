#!/bin/bash

# **************** Global variables
export HOME_PATH=$(pwd)

# IBM Cloud - elastic search variables
source ./.env

# **********************************************************************************
# Functions definition
# **********************************************************************************

function login_to_ibm_cloud () {
    
    echo ""
    echo "*********************"
    echo "Login IBM Cloud"
    echo "*********************"
    echo ""

    ibmcloud login --apikey $IBM_CLOUD_API_KEY 
    ibmcloud target -r $IBM_CLOUD_REGION
    ibmcloud target -g $IBM_CLOUD_RESOURCE_GROUP
}

function test_connection () {
  
    ELASTIC_URL=http://${E_HOST}:${E_PORT}

    echo ""
    echo "*********************"
    echo "Test connection"
    echo "*********************"
    echo ""
    echo "Basic CertFile: $E_CERT_PATH/$E_CERT_FILE_NAME"
    echo "Elastic URL: $ELASTIC_URL"

    echo "CURL from documentation: https://cloud.ibm.com/docs/databases-for-elasticsearch?topic=databases-for-elasticsearch-connecting-curl"
    CURL_CA_BUNDLE=$E_CERT_PATH/$E_CERT_FILE_NAME curl -u ${E_ADMIN_USER}:${E_ADMIN_PASSWORD} "https://${E_HOST}:${E_PORT}/_cluster/health?pretty"#
}

#**********************************************************************************
# Execution
# *********************************************************************************

#login_to_ibm_cloud
test_connection

