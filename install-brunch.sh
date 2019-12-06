#!/bin/bash
# Script to install brunch
sudo apt-get install npm -y
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update -y
sudo apt-get install nodejs -y
sudo npm install -g brunch
