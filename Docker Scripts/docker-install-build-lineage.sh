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

