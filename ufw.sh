#!/bin/bash
#
# Script to open all important ports on ufw
echo sudo 'ufw allow 8080/tcp'
sleep 1
echo sudo 'ufw allow 443/tcp'
sleep 2
echo sudo 'ufw allow 80/tcp'
sleep 3
echo sudo 'ufw allow 4422/tcp'
sleep 4
echo sudo 'ufw allow ssh'
sleep 5
echo sudo 'ufw status -verbose'
sleep 6
echo sudo 'ufw enable'
