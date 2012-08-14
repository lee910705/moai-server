#!/bin/sh
ProjectName="MoaiSample"
TargetName="moai"
SchemeName="MoaiSample"
#SDKS="iphoneos5.0"                                                                                                                                   
CONFIGURATIONS="Release"
ProvisionRelease=VBEnterpriseDistribution.mobileprovision
PASSWORD=qmflwm99
IDENTITY="iPhone Distribution: Vanilla Breeze Co., Ltd."
KEYCHAIN="/Users/admin/Library/Keychains/login.keychain"
PROJECT_PATH="/Users/Shared/Jenkins/Home/jobs/moai-test/workspace/moai-dev/xcode/ios "

# identify myself in git
git config --global user.email "lee910705@gmail.com"
git config --global user.name "Jae Joon Lee"

# location of the workspace
#pwd

# move to project folder

cd $PROJECT_PATH

# unlock security                                                                                                                                     
security unlock-keychain -p $PASSWORD $KEYCHAIN
# clean previous build files                                                                                                                          
xcodebuild -project $ProjectName.xcodeproj -target $TargetName -configuration $CONFIGURATIONS clean

# build project                                                                                                                                       
xcodebuild -project $ProjectName.xcodeproj -target $TargetName -configuration $CONFIGURATIONS
# archive ipa file                                                                                                                                    
#cd build                                                                                                                                             
rm -Rf Payload $TargetName.ipa

mkdir Payload
cp -r build/Release-iphoneos/$TargetName.app Payload
zip -r $TargetName.ipa iTunesArtwork Payload
#scp $TargetName.ipa $TargetName.plist ciuser@50.19.111.139:/hudson/www/touchholics.com/enterprise/iPhone                                             

#xcodebuild -project ../$ProjectName.xcodeproj -target $TargetName -sdk $SDKS -configuration $CONFIGURATIONS CODE_SIGN_IDENTITY="${IDENTITY}" OTHER_C\
#CODE_SIGN_FLAGS="--keychain ${KEYCHAIN}"