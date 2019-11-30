#!/usr/bin/env bash
#
# Script to Sync and Build bonito
mkdir DU
cd DU
repo init -u https://github.com/DirtyUnicorns/android_manifest.git -b p9x
repo sync -c --no-tags --force-sync -j$( nproc --all )
echo Sit back and chill
source build/envsetup.sh
lunch du_bonito-userdebug
mka bacon
echo Fry that shit bitch
