#!/bin/bash
#
# Script to open all important ports on ufw
echo Setting up ufw for access to ports
sudo ufw allow 8080/tcp
sleep 5
sudo ufw allow 443/tcp
sleep 5
sudo ufw allow 80/tcp
sleep 5
sudo ufw allow 4422/tcp
sleep 5
sudo ufw allow ssh
sleep 5
sudo ufw status -verbose
sleep 6
sudo ufw enable
#
echo Firewall setup complete
