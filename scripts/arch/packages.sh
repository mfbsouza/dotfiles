#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'


echo ""
echo -e "$GREEN Installing Packages... $CLEAR"
echo ""

sudo pacman -S plasma dolphin ffmpegthumbs kdegraphics-thumbnailers \
	kwalletmanager spectacle alacritty libva-utils vdpauinfo \
	systemd-resolvconf usb_modeswitch openssh openvpn wireguard-tools \
	networkmanager-openvpn networkmanager-l2tp networkmanager-strongswan \
	bash-completion usbutils tmux neovim xclip xsel tree wget picocom \
	nasm valgrind htop rsync stress inxi rofi meson cmake clang llvm openmp \
	python-pip python-pylint lcov gperf help2man diffstat chrpath \
	rpcsvc-proto inetutils spirv-headers krita firefox transmission-qt \
	vlc mpv discord telegram-desktop obs-studio jre-openjdk wireshark-qt \
	docker virt-manager qemu-desktop dnsmasq iptables-nft
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo -e "$GREEN Install nvidia, amd or intel graphic packages? [n/a/i] $CLEAR"
read ANSWER
if [ "$ANSWER" == "n" ]; then
	sudo pacman -S opencl-nvidia cuda nvidia-settings
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
elif [ "$ANSWER" == "a" ]; then
	sudo pacman -S mesa vulkan-radeon libva-mesa-driver opencl-mesa
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
elif [ "$ANSWER" == "i" ]; then
	sudo pacman -S mesa vulkan-intel intel-media-driver intel-compute-runtime
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
else
	echo -e "$RED wrong option... $CLEAR"
	exit 1
fi

echo -e "$GREEN Install gaming packages? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S mangohud steam wine-staging winetricks lutris
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
fi

echo ""
echo -e "$GREEN Installing yay... $CLEAR"
echo ""
 git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
 cd /tmp/yay-bin
 makepkg -si
 cd -


echo ""
echo -e "$GREEN Installing Google Chrome... $CLEAR"
echo ""
yay -S google-chrome

echo ""
echo -e "$GREEN enabling systemd services... $CLEAR"
echo ""
sudo systemctl enable sddm
sudo systemctl enable bluetooth
sudo systemctl enable ModemManager
sudo systemctl enable docker
sudo systemctl enable libvirtd

echo ""
echo -e "$GREEN Adding user to groups... $CLEAR"
echo ""

sudo usermod -a -G wireshark $USER
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
sudo usermod -a -G uucp $USER
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Done! $CLEAR"
echo ""
exit 0
