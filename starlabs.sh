#!/bin/bash
#
# Script to install starlabs theme
echo Downloading StarLabs Theme
sudo add-apt-repository ppa:starlabs/ppa
sudo apt update
sudo apt install starlabstheme
$> yes  |./starlabs.sh
echo Complete! Apply your theme!
