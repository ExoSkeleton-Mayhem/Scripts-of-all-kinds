#!/bin/bash
#
# Script to run Docker and build lineage
echo "Getting ready to build lineage-16.0!"
-e "BRANCH_NAME=lineage-16.0" \
-e "DEVICE_LIST=marlin" \
-e "SIGN_BUILDS=true" \
-e "CUSTOM_PACKAGES=FDroid FDroidPrivilegedExtension" \
-v "/home/user/lineage:/srv/src" \
-v "/home/user/zips:/srv/zips" \
-v "/home/user/logs:/srv/logs" \
-v "/home/user/cache:/srv/ccache" \
-v "/home/user/keys:/srv/keys" \
-v "/home/user/manifests:/srv/local_manifests" \
lineageos4microg/docker-lineage-cicd
echo "wait for it!, Have a cup of coffe or do some BLOW!"

