#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'

echo ""
echo -e "$GREEN Disabling OpenSUSE weird repo... $CLEAR"
echo ""

sudo zypper mr -d repo-openh264

echo ""
echo -e "$GREEN Updating the system packages... $CLEAR"
echo ""

sudo zypper refresh
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

sudo zypper update
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Installing OPI and Codecs... $CLEAR"
echo ""

sudo zypper install opi
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi
opi codecs
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi
sudo zypper dist-upgrade --from packman --allow-downgrade --allow-vendor-change
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Printing repo priorities... $CLEAR"
echo ""

sudo zypper lr -P
sleep 5

echo ""
echo -e "$GREEN Installing Packages... $CLEAR"
echo ""

sudo zypper install -t pattern devel_C_C++ devel_python3 devel_kernel \
	network_admin kvm_server kvm_tools
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

sudo zypper install fastfetch libva-utils neovim ripgrep clang-tools \
	meson llvm Bear cmake nasm tmux lcov docker htop stress-ng \
	picocom discord steam lutris mangohud vkbasalt vlc obs-studio \
	telegram-desktop go
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

go install golang.org/x/tools/gopls@latest
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

sudo systemctl enable libvirtd
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Installing Rust Lang... $CLEAR"
echo ""

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.cargo/bin/rust-analyzer
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

chmod +x $HOME/.cargo/bin/rust-analyzer
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Installing Google Chrome... $CLEAR"
echo ""

opi google-chrome
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Installing Microsoft Teams... $CLEAR"
echo ""

opi teams
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

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
