#!/bin/bash

echo "Installing LightDM Display Manager"

sudo pacman -S lightdm lightdm-gtk-greeter --noconfirm

sudo systemctl enable lightdm.service

sudo cp ../etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/
sudo cp ../wallpaper/1522333936.jpg /usr/share/pixmaps/
