#!/usr/bin/env bash

# Post Build Script

set -e # Exit immediately if a command exits with a non-zero status (failure)

echo "**************************************************************************************************"
echo "Post Build Script"
echo "**************************************************************************************************"

##################################################
# Build Xamarin.UITest (For building Xamarin.Android. If you are building Xamarin iOS, please just comment out this part as .sln will run it)
##################################################

msbuild $APPCENTER_SOURCE_DIRECTORY/TestXamarinForms/TestXamarinForms/TestXamarinForms.UITest.csproj /t:Build /p:Configuration=Debug

##################################################
# Start UI Tests
##################################################

# variables
appCenterLoginApiToken=$AppCenterLoginForAutomatedUITests # this comes from the build environment variables
appName="$AppOwner/$AppName" # this comes from the build environment variables
deviceSetName="$AppOwner/$AppDeviceSetName" # this comes from the build environment variables
testSeriesName="$AppTestSeriesName" # this comes from the build environment variables

echo ""
echo "Start Xamarin.UITest run"
echo "   App Name: $appName"
echo " Device Set: $deviceSetName"
echo "Test Series: $testSeriesName"
echo ""

echo "> Run UI test command"
# Note: must put a space after each parameter/value pair
appcenter test run uitest --app $appName --devices $deviceSetName --app-path $APPCENTER_OUTPUT_DIRECTORY/Pickster.ipa --test-series $testSeriesName --locale "en_US" --build-dir $APPCENTER_SOURCE_DIRECTORY/Pickster.UITests/bin/Debug --uitest-tools-dir $APPCENTER_SOURCE_DIRECTORY/packages/Xamarin.UITest.*/tools --token $appCenterLoginApiToken 

echo ""
echo "**************************************************************************************************"
echo "Post Build Script complete"
echo "**************************************************************************************************"
