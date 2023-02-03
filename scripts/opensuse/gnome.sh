#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

echo -e "$GREEN Configuring gnome... $CLEAR"

gsettings set org.gnome.desktop.peripherals.mouse accel-profile flat
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'
gsettings set org.gnome.Terminal.Legacy.Settings headerbar false
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

echo -e "$GREEN Done! $CLEAR"
