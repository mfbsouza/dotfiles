#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'

echo ""
echo -e "$GREEN Updating the system packages... $CLEAR"
echo ""

sudo apt update && sudo apt upgrade
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Installing Packages... $CLEAR"
echo ""

sudo apt install neofetch docker.io
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Installing ripgrep... $CLEAR"
echo ""

wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi
sudo dpkg -i ripgrep_13.0.0_amd64.deb
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi
rm ripgrep_13.0.0_amd64.deb

echo ""
echo -e "$GREEN Adding user to groups... $CLEAR"
echo ""

sudo usermod -a -G dialout $USER
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi
sudo usermod -a -G docker $USER
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Done! $CLEAR"
echo ""
exit 0
