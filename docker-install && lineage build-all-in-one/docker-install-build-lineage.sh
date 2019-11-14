!#/bin/bash
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
sudo apt-get install screen
sleep10
sudo docker run \
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
echo "now sit back and relax while docker builds lineage"