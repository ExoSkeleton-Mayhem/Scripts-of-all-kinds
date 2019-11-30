#!/bin/bash
# Script to update the system on a regular basis
sudo apt-get --assume-yes update
sudo apt-get --assume-yes update -y
sudo apt-get --assume-yes upgrade
#!/bin/bash
sudo apt-get --assume-yes dist-upgrade
sudo apt-get --assume-yes install -y
sudo apt-get --assume-yes autoremove 
sudo apt-get --assume-yes autoclean

