#!/usr/bin/env bash

# Post Clone Script

echo "**************************************************************************************************"
echo "Post Clone Script"
echo "**************************************************************************************************"

#######################################################
# Detect the platform and stop build process if needed
#######################################################

# variables
appPlatform=$appPlatform # this comes from the build environment variables
lastCommitedComment=$LASTCOMMITMESSAGE 
API_Token=$APIToken
AppOwner=$AppOwnerName
AppName=$AppName

if [[ $lastCommitedComment == *'[$appPlatform]'* ]]; then
    echo "Update mismatch platform, stop building.."
    # exit(1)
    curl -i -X PATCH -H "X-API-Token:$API_Token" -H "Content-Type: application/json" -d "{\"status\":\"cancelling\"}" https://appcenter.ms/api/v0.1/apps/$AppOwnerName/$AppName/builds/$APPCENTER_BUILD_ID
fi