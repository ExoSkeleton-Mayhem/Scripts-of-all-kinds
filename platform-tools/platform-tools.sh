#!/bin/bash
# Script to get and install platform-tools\
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip
cd /Downloads
unzip platform-tools-latest-linux.zip -d ~
export PATH=$PATH:/home/centurion/platform-tools
source ~/.profile
export PATH=$PATH:/home/centurion/android-ndk-r20b-linux-x86_64/android-ndk-r20b
export PATH=$PATH:/home/centurion/sdk-tools-linux-3859397/tools
# add Android SDK platform tools to path
if [ -d "$HOME/platform-tools" ] ; then
    PATH="$HOME/platform-tools:$PATH"
fi
source ~/.profile

#!/bin/bash
# Script addition to install openjdk
sudo apt-get install openjdk-8-jre -y
sudo apt-get isntall openjdk-8-jdk
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade -y

