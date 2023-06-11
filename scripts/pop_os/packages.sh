#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'

echo ""
echo -e "$GREEN Updating the system packages... $CLEAR"
echo ""

sudo apt update && sudo apt upgrade
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Installing Packages... $CLEAR"
echo ""

sudo apt install picocom autoconf automake gperf \
	texinfo help2man libtool libtool-bin gawk libncurses-dev \
	meson ninja-build clang llvm clang-format python3-pip cmake \
	bear tree nasm qemu-system-x86 qemu-system-misc valgrind mypaint \
	ubuntu-restricted-extras ffmpegthumbnailer lm-sensors htop wireguard \
	transmission-gtk vlc libvulkan-dev vulkan-tools mesa-utils vainfo \
	openssh-server gcc-avr gdb-avr avr-libc avrdude network-manager-l2tp \
	network-manager-l2tp-gnome virt-manager obs-studio tmux clangd lcov \
	stress inxi golang golang-golang-x-tools code telegram-desktop discord \
	libsdl2-dev libglew-dev libglm-dev libsdl2-image-dev default-jre \
	docker.io diffstat chrpath socat python3-pexpect python3-git default-jdk \
	python3-jinja2 libegl1-mesa libsdl1.2-dev pylint python3-subunit \
	libu2f-udev libgdk-pixbuf-xlib-2.0-0 libgdk-pixbuf2.0-0 alacritty \
	bison libssl-dev libelf-dev libpci-dev libiberty-dev i3 vdpauinfo \
	mesa-common-dev liblz4-tool wireshark mangohud vkbasalt steam lutris
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

go install golang.org/x/tools/gopls@latest

echo ""
echo -e "$GREEN Installing Google Chrome... $CLEAR"
echo ""

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi
sudo dpkg -i google-chrome-stable_current_amd64.deb
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi
rm google-chrome-stable_current_amd64.deb

echo ""
echo -e "$GREEN Adding user to groups... $CLEAR"
echo ""

sudo usermod -a -G dialout $USER
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
sudo usermod -a -G wireshark $USER
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
