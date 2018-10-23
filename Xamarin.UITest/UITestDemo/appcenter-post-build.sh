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

# variables
appCenterLoginApiToken=$AppCenterLoginForAutomatedUITests # this comes from the build environment variables
appName="KevinApps/AppCenter-Test-Samples"
deviceSetName="KevinApps/iphone7-12"
testSeriesName="master"

echo ""
echo "Start Xamarin.UITest run"
echo "   App Name: $appName"
echo " Device Set: $deviceSetName"
echo "Test Series: $testSeriesName"
echo ""

echo "> Run UI test command"
# Note: must put a space after each parameter/value pair
appcenter test run uitest --app $appName --devices $deviceSetName --app-path $APPCENTER_OUTPUT_DIRECTORY/Pickster.ipa --test-series $testSeriesName --locale "en_US" --build-dir $APPCENTER_SOURCE_DIRECTORY/Pickster.UITests/bin/Debug --token $appCenterLoginApiToken 

echo ""
echo "**************************************************************************************************"
echo "Post Build Script complete"
echo "**************************************************************************************************"
