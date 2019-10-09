#!/bin/bash
#
# Script to get a list of all aosp-mirror clone directories
echo Get Ready Bitches! Here Comes Your Fucking List!
rest 1

curl "https://api.github.com/users/aosp-mirror/repos?per_page=100&page=1" | jq -r '.[] | .name'
rest2

echo There ya go MuthaFucka!
