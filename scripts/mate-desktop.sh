#!/bin/bash

echo "Installing MATE Desktop Enviroment..."
sudo pacman -S mate mate-extra mate-media blueman network-manager-applet mate-power-manager system-config-printer mate-screensaver gtk-engines gtk-engine-murrine libcanberra libcanberra-pulse xdg-user-dirs gnome-keyring --noconfirm
