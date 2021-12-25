#!/bin/bash

sudo pacman -S libvirt virt-manager qemu qemu-arch-extra edk2-ovmf \
	iptables-nft dnsmasq

sudo systemctl enable libvirtd.service

