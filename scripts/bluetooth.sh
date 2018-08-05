#!/bin/bash

echo "Setting up Bluetooth drivers..."
sudo pacman -S pulseaudio-bluetooth bluez bluez-libs bluez-utils --noconfirm
sudo systemctl enable bluetooth.service
