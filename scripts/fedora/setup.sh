#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'


echo -e "\n$GREEN Fedora i3 spin personal setup script by mfbsouza $CLEAR\n"

echo -e "\n$GREEN enable rpm fusion? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	sudo dnf update
	sudo dnf config-manager --enable fedora-cisco-openh264
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	sudo dnf update
fi

echo -e "\n$GREEN install multimedia codecs? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf swap ffmpeg-free ffmpeg --allowerasing
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	sudo dnf groupupdate multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	sudo dnf groupupdate sound-and-video
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install basic terminal packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install lm_sensors git htop btop fzf \
		fd-find ripgrep vim neovim stress fastfetch
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install complementary i3wm packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install picom blueman xfce4-settings xdotool xclip
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install Alacritty? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install alacritty
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install TLP for power managment? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install tlp tlp-rdw
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	echo -e "\n$GREEN enabling TLP service... $CLEAR\n"
	sudo systemctl enable tlp.service
	sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
fi

echo -e "\n$GREEN Install software development packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install go python3-pip
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install vlc and mpv? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install vlc mpv
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install transmission-gtk package? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install transmission-gtk
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi
