#!/usr/bin/env bash

# Post Build Script

set -e # Exit immediately if a command exits with a non-zero status (failure)

echo "**************************************************************************************************"
echo "Post Build Script"
echo "**************************************************************************************************"

/Library/Frameworks/Mono.framework/Versions/5_12_0/bin/msbuild /Users/vsts/agent/2.140.2/work/1/s/Xamarin.UITest/UITestDemo/UITestDemo.UITest/UITestDemo.UITest.csproj /t:Build /p:Configuration=Debug

##################################################
# Start UI Tests
##################################################

cd $APPCENTER_SOURCE_DIRECTORY
ls
