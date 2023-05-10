#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'

echo -e "$GREEN Updating the system packages... $CLEAR"

sudo apt update && sudo apt upgrade
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo -e "$GREEN Installing Packages... $CLEAR"

sudo apt install docker.io tree build-essential ninja-build gettext cmake unzip
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo -e "$GREEN Adding user to groups... $CLEAR"

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

echo -e "$GREEN Done! $CLEAR"
exit 0
