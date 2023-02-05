#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e ""
echo -e "$GREEN Configuring gnome... $CLEAR"
echo -e ""

gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'
gsettings set org.gnome.Terminal.Legacy.Settings headerbar false

echo -e ""
echo -e "$GREEN Done! $CLEAR"
echo -e ""
