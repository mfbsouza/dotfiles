#!/bin/bash

echo "Installing packages for HW Accel Virtualization..."

sudo pacman -S qemu ovmf libvirt virt-manager ebtables dnsmasq dmidecode --noconfirm
sudo systemctl enable --now libvirtd.service virtlogd.socket ebtables.service dnsmasq.service

sudo gpasswd -a bois libvirt
