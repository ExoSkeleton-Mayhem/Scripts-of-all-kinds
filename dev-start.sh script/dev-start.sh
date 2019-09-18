#!/bin/bash
# A script to install all your needed developing packages
#
LSB_RELEASE="$(lsb_release -d | cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//')"
INSTALL_DEVELOPERS_PACKAGES=[[ sudo apt-get install build-essential && apt-get install openjdk-8-jdk && apt-get install python3 && apt-get install python-pip && apt-get install adb && apt-get install fastboot && apt-get install repo && apt-get install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev]]; 
echo mkdir -p ~/bin
echo curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
echo $chmod a+x ~/bin/repo
echo # set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
#
echo | source ~/.profile

