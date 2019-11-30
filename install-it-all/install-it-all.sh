#!/bin/bash 
############################################################################
#
#                                       
#                          ./+o+-       
#                  yyyyy- -yyyyyy+      
#               ://+//////-yyyyyyo      
#           .++ .:/++++++/-.+sss/`      
#         .:++o:  /++++++++/:--:/-      
#        o:+o+:++.`..```.-/oo+++++/     
#       .:+o:+o/.          `+sssoo+/    
#  .++/+:+oo+o:`             /sssooo.   
# /+++//+:`oo+o               /::--:.   
# \+/+o+++`o++o               ++////.   
#  .++.o+++oo+:`             /dddhhh.   
#       .+.o+oo:.          `oddhhhh+    
#        \+.++o+o``-````.:ohdhhhhh+     
#         `:o+++ `ohhhhhhhhyo++os:      
#           .o:`.syhhhhhhh/.oo++o`      
#               /osyyyyyyo++ooo+++/     
#                   ````` +oo+++o\:    
#                          `oo++.      
#                                
#
#
############################################################################
# Author 	: 	Erik Dubois
# Website 	: 	http://www.erikdubois.be
############################################################################
# More from Erik Dubois
#
# Aurora conky and all its components are installed via an other script
# at http://sourceforge.net/projects/auroraconkytheme/
# Explanation on the use of this theme can be found at 
# http://erikdubois.be/
#
# Sardi icons can be found at
# http://sourceforge.net/projects/sardi/
#
# Yltra flat icons can be found at 
# https://github.com/erikdubois/yltra-flat-icon-theme
############################################################################
#
# the option -y has been added. It will autoinstall all. Omit if you do not want that.
#
############################################################################


############################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. AT YOUR OWN RISK.
#
############################################################################

#software from 'normal' repositories
echo "software from 'normal' repositories"
sudo apt install -y catfish clementine curl evolution focuswriter frei0r-plugins geary gimp git gpick glances gparted
sudo apt install -y hardinfo inkscape inxi kazam openshot p7zip-full ppa-purge radiotray screenruler scrot shutter slurm
sudo apt install -y thunar vnstat winbind screenfetch plank
sudo apt install -y browser-plugin-vlc vlc
sudo apt install breeze-cursor-theme -y


############################################################################

# installation of zippers and unzippers
echo "installation of zippers and unzippers"
sudo apt install -y p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller

############################################################################

#software from extra repositories
echo "software from extra repositories"

sh ./install-google-chrome-v*.sh
sh ./install-grub-customizer-v*.sh
sh ./install-spotify-v*.sh 
sh ./install-sublime-text-v*.sh 
sh ./install-variety-v*.sh  


############################################################################

#software operating system specific

sudo apt install -y gnome-tweak-tool compizconfig-settings-manager  

# fixing error gtk-warning-unable-to-locate-theme-engine-in-module-path-adwaita-error
# making assets mint-y-colora
sudo apt install gnome-themes-standard -y

############################################################################

#developer tools for android development

LSB_RELEASE="$(lsb_release -d | cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//')"
INSTALL_DEVELOPERS_PACKAGES=[[ sudo apt-get install build-essential && apt-get install openjdk-8-jdk && apt-get install python3 && apt-get install python-pip && apt-get install adb && apt-get install fastboot && apt-get install repo && apt-get install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev]]; 
echo mkdir -p ~/bin
echo curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
echo $chmod a+x ~/bin/repo
echo PATH=~/home/bin:$PATH
echo | source ~/.profile

############################################################################
# Copyright (C) 2018 Harsh 'MSF Jarvis' Shandilya
# Copyright (C) 2018 Akhil Narang
# SPDX-License-Identifier: GPL-3.0-only

# Script to setup an AOSP Build environment on Ubuntu and Linux Mint
git clone https://github.com/akhilnarang/scripts
cd scripts
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


############################################################################

# Script to install starlabs theme
cd ..
echo Downloading StarLabs Theme
sudo add-apt-repository ppa:starlabs/ppa
sudo apt update -y
sudo apt install starlabstheme -y

echo Complete! Apply your theme!

############################################################################

#Update packages and sweeten the system
sudo apt-get update -y


##########################################################################

# Installing Repo and placing to path
echo '###Installing Repo and Bin..'
echo mkdir -p ~/bin
echo curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
echo $chmod a+x ~/bin/repo
echo PATH=~/home/bin:$PATH
echo | source ~/.profile


echo 'Repo was Installed!'

#ending
