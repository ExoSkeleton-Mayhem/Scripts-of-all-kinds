#!/bin/bash
#
# Script to setup entire Android-Dev environment.
#!/bin/bash
# A script to install all your needed developing packages
#
LSB_RELEASE="$(lsb_release -d | cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//')"
INSTALL_DEVELOPERS_PACKAGES=[[ sudo apt-get install build-essential && apt-get install openjdk-8-jdk && apt-get install python3 && apt-get install python-pip && apt-get install adb && apt-get install fastboot && apt-get install repo && apt-get install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev]]; 
echo mkdir -p ~/bin
echo curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
echo $chmod a+x ~/bin/repo
echo PATH=~/home/bin:$PATH
echo | source ~/.profile
#!/usr/bin/env bash

# Copyright (C) 2018 Harsh 'MSF Jarvis' Shandilya
# Copyright (C) 2018 Akhil Narang
# SPDX-License-Identifier: GPL-3.0-only

# Script to setup an AOSP Build environment on Ubuntu and Linux Mint

LATEST_MAKE_VERSION="4.2.1"
LATEST_NINJA_VERSION="1.9.0.git"
UBUNTU_14_PACKAGES="binutils-static curl figlet libesd0-dev libwxgtk2.8-dev schedtool"
UBUNTU_16_PACKAGES="libesd0-dev"
UBUNTU_18_PACKAGES="curl"
DEBIAN_10_PACKAGES="curl rsync"
PACKAGES=""

LSB_RELEASE="$(lsb_release -d | cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//')"

if [[ "${LSB_RELEASE}" =~ "Ubuntu 14" ]]; then
    PACKAGES="${UBUNTU_14_PACKAGES}"
elif [[ "${LSB_RELEASE}" =~ "Mint 18" || "${LSB_RELEASE}" =~ "Ubuntu 16" ]]; then
    PACKAGES="${UBUNTU_16_PACKAGES}"
elif [[ "${LSB_RELEASE}" =~ "Ubuntu 18" || "${LSB_RELEASE}" =~ "Ubuntu 19" || "${LSB_RELEASE}" =~ "Deepin" ]]; then
    PACKAGES="${UBUNTU_18_PACKAGES}"
elif [[ "${LSB_RELEASE}" =~ "Debian GNU/Linux 10" ]]; then
    PACKAGES="${DEBIAN_10_PACKAGES}"
fi

sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt install -y adb autoconf automake axel bc bison build-essential ccache clang cmake expat fastboot flex \
    g++ g++-multilib gawk gcc gcc-multilib git-core gnupg gperf htop imagemagick lib32ncurses5-dev lib32z1-dev libtinfo5 \
    libc6-dev libcap-dev libexpat1-dev libgmp-dev liblz4-* liblzma* libmpc-dev libmpfr-dev \
    libncurses5-dev libsdl1.2-dev libssl-dev libtool libxml2 libxml2-utils lzma* lzop maven ncftp ncurses-dev \
    patch patchelf pkg-config pngcrush pngquant python python-all-dev re2c schedtool squashfs-tools subversion texinfo \
    unzip w3m xsltproc zip zlib1g-dev lzip "${PACKAGES}"

# For all those distro hoppers, lets setup your git credentials
GIT_USERNAME="$(git config --get user.name)"
GIT_EMAIL="$(git config --get user.email)"
echo "Configuring Git"
if [[ -z ${GIT_USERNAME} ]]; then
	echo "Enter your name: "
	read -r NAME
	git config --global user.name "${NAME}"
fi
if [[ -z ${GIT_EMAIL} ]]; then
	echo "Enter your email: "
	read -r EMAIL
	git config --global user.email "${EMAIL}"
fi
git config --global credential.helper "cache --timeout=7200"
echo "Github credentials setup successfully"

# From Ubuntu 18.10 onwards and Debian Buster libncurses5 package is not available, so we need to hack our way by symlinking required library
# shellcheck disable=SC2076
if [[ "${LSB_RELEASE}" =~ "Ubuntu 18.10" || "${LSB_RELEASE}" =~ "Ubuntu 19" || "${LSB_RELEASE}" =~ "Debian GNU/Linux 10" ]]; then
    if [[ -e /lib/x86_64-linux-gnu/libncurses.so.6 && ! -e /usr/lib/x86_64-linux-gnu/libncurses.so.5 ]]; then
        sudo ln -s /lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5
    fi
fi

if [[ ! "$(command -v adb)" == "" ]]; then
    echo -e "Setting up udev rules for adb!"
    sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
    sudo chmod 644 /etc/udev/rules.d/51-android.rules
    sudo chown root /etc/udev/rules.d/51-android.rules
    sudo systemctl restart udev
    adb kill-server
    sudo killall adb
fi

if [[ "$(command -v make)" ]]; then
    makeversion="$(make -v | head -1 | awk '{print $3}')"
    if [[ "${makeversion}" != "${LATEST_MAKE_VERSION}" ]]; then
        echo "Installing make ${LATEST_MAKE_VERSION} instead of ${makeversion}"
        bash ./setup/make.sh "${LATEST_MAKE_VERSION}"
    fi
fi

echo "Installing repo"
sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://github.com/akhilnarang/repo/raw/master/repo
sudo chmod a+x /usr/local/bin/repo

if [[ "$(command -v ninja)" ]]; then
    ninjaversion="$(ninja --version)"
    if [[ "${ninjaversion}" != "${LATEST_NINJA_VERSION}" ]]; then
        echo "Installing ninja ${LATEST_NINJA_VERSION} instead of ${ninjaversion}"
        bash ./setup/ninja.sh
    fi
else
    bash ./setup/ninja.sh
fi

echo installing starlabs theme
sudo add-apt-repository ppa:starlabs/ppa
sudo apt update
sudo apt install starlabstheme
echo git clone https://github.com/StarLabsLtd/StarLabsTheme.git

echo git config --global user.email westcoastroms@gmail.com
echo git config --global user.name Eric Tony
echo ssh-keygen -t rsa -b 4096 -C "westcoastroms@gmail.com"
echo eval "$(ssh-agent -s)"
echo ssh-add ~/.ssh/id_rsa

echo sudo apt-get update && apt-get upgrade -y
sleep 10

#!/bin/sh
#
# Script to install all git-scripts to be executable from anywhere!
echo sudo ln -s /home/centurion/.local/bin/git-scripts/git-all-commits /usr/local/bin/git-all-commits
echo sudo ln -s /home/centurion/.local/bin/git-scripts/git-all-objects /usr/local/bin/git-all-objects
echo sudo ln -s /home/centurion/.local/bin/git-scripts/git-apply-url /usr/local/bin/git-apply-url
echo sudo ln -s /home/centurion/.local/bin/git-scripts/git-amend-all /usr/local/bin/git-amend-all
echo sudo ln -s /home/centurion/.local/bin/git-scripts/git-checkout-branches /usr/local/bin/git-checkout-branches
echo sudo ln -s /home/centurion/.local/bin/git-scripts/git-clone.sh /usr/local/bin/git-clone.sh
echo sudo ln -s /home/centurion/.local/bin/git-scripts/git-every /usr/local/bin/git-every
echo sudo ln -s /home/centurion/.local/bin/git-scripts/git-forest /usr/local/bin/git-forest
echo sudo ln -s /home/centurion/.local/bin/git-scripts/git-push-all /usr/local/bin/git-push-all
echo sudo ln -s /home/centurion/.local/bin/git-scripts/git-push-branch /usr/local/bin/git-push-branch
echo sudo git config --global user.email ericharper34@hotmail.com
echo sudo git config --global user.name Eric
#!/bin/bash
#
# Script tp install and build docker and lineage for your device
echo "Lets install docker you cock smear!"
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
echo "adding Dockers official Key!"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "Checking for valid fingerprint"
#
sudo apt-key fingerprint 0EBFCD88
echo "adding in the repository you dumb fuck!"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo apt-get install docker   
echo sudo docker run hello-world
echo "lets install the screen!"
sudo | apt-get install screen

#!/bin/bash
#
# Script to install npm and nodejs
echo "NPM and Nodejs coming up"
sudo apt-get update
sudo apt-get install npm
sudo apt-get install nodejs
sudo apt-get install python-pip
sudo apt-get install gitup
sudo apt-get install myrepos
sudo apt-get install and
sudo npm install brunch

#!/bin/bash
#
# Script to install Jenkins
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
wget http://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.27/bin/apache-tomcat-9.0.27.tar.gz -P /tmp
sudo tar xf /tmp/apache-tomcat-9*.tar.gz -C /opt/tomcat
sudo ln -s /opt/tomcat/apache-tomcat-9.0.27 /opt/tomcat/latest
sudo chown -RH tomcat: /opt/tomcat/latest
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
sudo systemctl daemon-reload
sudo systemctl start tomcat
wget https://pkg.jenkins.io/debian-stable/binary/jenkins_2.190.2_all.deb
#!/bin/bash
# A script to install all your needed developing packages
#
LSB_RELEASE="$(lsb_release -d | cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//')"
INSTALL_DEVELOPERS_PACKAGES=[[ sudo apt-get install build-essential && apt-get install openjdk-8-jdk && apt-get install python3 && apt-get install python-pip && apt-get install adb && apt-get install fastboot && apt-get install repo && apt-get install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev]]; 
echo mkdir -p ~/bin
echo curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
echo $chmod a+x ~/bin/repo
echo PATH=~/home/bin:$PATH
echo | source ~/.profile
#! /bin/bash

TEMP_DIR=/tmp


VERSION=`curl --silent "https://api.github.com/repos/protocolbuffers/protobuf/releases/latest" | grep -Po '"tag_name": "v\K.*?(?=")'`

[[ -z VERSION ]] && echo "Could not get version from github"

mkdir $TEMP_DIR/protoc_inst

cd $TEMP_DIR/protoc_inst

# Make sure you grab the latest version
curl -OL "https://github.com/google/protobuf/releases/download/v$VERSION/protoc-$VERSION-linux-x86_64.zip"

# Unzip
unzip "protoc-$VERSION-linux-x86_64.zip" -d protoc3

# Move protoc to /usr/local/bin/
sudo mv protoc3/bin/* /usr/local/bin/

# Move protoc3/include to /usr/local/include/
sudo mv protoc3/include/* /usr/local/include/

rm -rf $TEMP_DIR/protoc_inst
#!/usr/bin/env bash

cd /tmp || exit 1
git clone git://github.com/ccache/ccache.git
cd ccache || exit 1
./autogen.sh
./configure --disable-man --with-libzstd-from-internet --with-libb2-from-internet
make -j"$(nproc)"
sudo make install
rm -rf "${PWD}"
cd - || exit 1
#!/usr/bin/env bash

# Script to setup the Android SDK on a Linux System
CUR_DIR="$(cd "$( dirname "$( readlink -f "${BASH_SOURCE[0]}" )" )" && pwd)"
CUR_DIR="${CUR_DIR/setup/}"
SDK_DIR="${HOME}/Android/Sdk"
TOOLS_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ZIP_NAME=sdk.zip
mkdir -p "${SDK_DIR}"/
cd /tmp/ || exit 1
if axel -a -n 10 "${TOOLS_URL}" -o "${ZIP_NAME}"  || wget "${TOOLS_URL}" -O "${ZIP_NAME}"; then
    unzip -o "${ZIP_NAME}" -d "${SDK_DIR}" && rm "${ZIP_NAME}"
else
    exit 1
fi

# Create repositories.cfg if not present
if [ ! -f ~/.android/repositories.cfg ] ; then
    touch ~/.android/repositories.cfg
fi

if [ -z "${ANDROID_HOME}" ]; then
    printf "\nexport ANDROID_HOME=%s" "${SDK_DIR}" >> ~/.bashrc
fi
if [ -z "${ANDROID_SDK_ROOT}" ]; then
    printf "\nANDROID_SDK_ROOT=%s" "${SDK_DIR}" >> ~/.bashrc
fi

yes | "${SDK_DIR}"/tools/bin/sdkmanager --licenses

while read -r p; do
    "${SDK_DIR}"/tools/bin/sdkmanager "${p}"
done < "${CUR_DIR}/setup"/android-sdk-minimal.txt

cd "${CUR_DIR}" || exit
#!/usr/bin/env bash

cd /tmp || exit 1
axel -a -n 10 https://ftp.gnu.org/gnu/make/make-"${1:?}".tar.gz
tar xvzf /tmp/make-"${1:?}".tar.gz
cd /tmp/make-"${1:?}" || exit 1
./configure
curl https://raw.githubusercontent.com/akhilnarang/scripts/master/patches/make-glibc_alloc_fix.patch | patch -p1
bash ./build.sh
sudo install ./make /usr/local/bin/make
cd - || exit 1
rm -rf /tmp/make-"${1:?}"{,.tar.gz}
