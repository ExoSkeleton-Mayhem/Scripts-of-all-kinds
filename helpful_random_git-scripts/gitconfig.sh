#!/bin/bash
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
