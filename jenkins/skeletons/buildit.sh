#!/bin/bash
cd ~/Skeletons/
repo init -u https://github.com/LineageOS/android.git -b lineage-17.0
repo sync -c --force-sync -j$( nproc --all )
make clobber
cd ~/Skeletons/
ccache -M 35G
export PATH=~/bin:$PATH
export USE_CCACHE=1
repo sync -c --no-tags --force-sync -j$( nproc --all )
vendor/lineage/get-prebuilts
source build/envsetup.sh && time brunch marlin
