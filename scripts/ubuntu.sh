#!/bin/bash
echo "Configuring git"
git config --global user.name "mfbsouza"
git config --global user.email "mfbs@cin.ufpe.br"
git config --global core.editor "vim"

echo "Adding user to groups"
sudo adduser `id -un` libvirtd
sudo adduser `id -un` dialout

echo "Configuring VAAPI"
sudo echo "LIBVA_DRIVER_NAME=i965" >> /etc/environment 

echo "Installing some small softwares"
sudo apt install vim neofetch mesa-utils lm-sensors

echo "Installing dev packages"
sudo apt install build-essential cmake golang python3-pip libomp-dev\
	libsdl2-dev libsdl2-mixer-dev libsdl2-ttf-dev libsdl2-gfx-dev\
	libsdl2-image-dev libsdl2-net-dev

echo "Installing KVM/Virtualization"
sudo apt install qemu-kvm libvirt-deamon-system\
	libvirt-clients bridge-utils virt-manager

echo "Installing Snap packages"
sudo snap install --channel=candidate/vaapi chromium
sudo snap install audacity blender code discord obs-studio spotify telegram-desktop vlc

echo "Please reboot your PC"
