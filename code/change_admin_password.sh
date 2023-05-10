#!/bin/bash

# **************** Global variables
HOME_PATH=$(pwd)

# IBM Cloud - elastic search variables
source ./.env

# **********************************************************************************
# Functions definition
# **********************************************************************************

function login_to_ibm_cloud () {
    
    echo ""
    echo "*********************"
    echo "loginIBMCloud"
    echo "*********************"
    echo ""

    ibmcloud login --apikey $IBM_CLOUD_API_KEY 
    ibmcloud target -r $IBM_CLOUD_REGION
    ibmcloud target -g $IBM_CLOUD_RESOURCE_GROUP
}

#**********************************************************************************
# Execution
# *********************************************************************************

login_to_ibm_cloud 
ibmcloud cdb user-password $E_SEARCH_SERVICE admin $E_ADMIN_PASSWORD