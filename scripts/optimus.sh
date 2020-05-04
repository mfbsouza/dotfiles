#!/bin/bash

echo "Setting up for Nvidia Optimus..."

sudo pacman -S bbswitch --noconfirm
yay -S optimus-manager --noconfirm

sudo cp ../etc/optimus-manager/optimus-manager.conf /etc/optimus-manager/

sudo pacman -S nvidia-prime --noconfirm
yay -S switcheroo-control --noconfirm
sudo systemctl enable switcheroo-control
