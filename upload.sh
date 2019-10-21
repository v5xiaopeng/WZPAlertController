#!/bin/bash

VersionString=`grep -E 's.version.*=' WZPAlertController.podspec`
VersionNumber=`tr -cd 0-9 <<<"$VersionString"`

NewVersionNumber=$(($VersionNumber + 1))
LineNumber=`grep -nE 's.version.*=' WZPAlertController.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" WZPAlertController.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git add .
git commit -am '添加注释、代码规范' #${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
pod repo push WZPRepoSpecs WZPAlertController.podspec --verbose --allow-warnings --use-libraries --use-modular-headers

