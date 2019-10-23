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

# In Ubuntu 18.10 and Debian Buster libncurses5 package is not available, so we need to hack our way by symlinking required library
if [[ "${LSB_RELEASE}" =~ "Ubuntu 18.10" || "${LSB_RELEASE}" =~ "Debian GNU/Linux 10" ]]; then
  if [[ -e /lib/x86_64-linux-gnu/libncurses.so.6 && ! -e /usr/lib/x86_64-linux-gnu/libncurses.so.5 ]]; then
    sudo ln -s /lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5
  fi
fi

############################################################################

# Script to install starlabs theme
echo Downloading StarLabs Theme
sudo add-apt-repository ppa:starlabs/ppa
sudo apt update
sudo apt install starlabstheme

echo Complete! Apply your theme!

############################################################################

#Update packages and sweeten the system
sudo apt-get update -y

## Git ##
echo '###Installing Git..'
sudo apt-get install git -y

# Configuring Git
echo '###Configuring Git..'



echo "Enter the Global Username for Git:";
read GITUSER;
git config --global user.name "${GITUSER}"

echo "Enter the Global Email for Git:";
read GITEMAIL;
git config --global user.email "${GITEMAIL}"

echo 'Git was Configured,Go Forth and Spawn Repos!'
git config --list

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
