#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'


echo -e "\n$GREEN Fedora i3 spin personal setup script by mfbsouza $CLEAR\n"

echo -e "\n$GREEN this scripts expects that you have already setup the RPM \
fusion repos and followed the steps to swap the built-in ffmpeg for the \
non-free version. Do you want to continue? [Y/n] $CLEAR\n"
read ANS
if [ "$ANS" == "n" ]; then
	exit 1
fi

echo -e "\n$GREEN install AMD multimedia codecs? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install ffmpegthumbnailer? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install ffmpegthumbnailer
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install VAAPI util packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install libva-utils
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install basic terminal packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install vim lm_sensors git htop btop fzf \
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

echo -e "\n$GREEN Install TLP for power managment? Make sure to disable \
SELinux before installing tlp. [y/N] $CLEAR\n"
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
	sudo dnf install go python3-pip clang llvm
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

echo -e "\n$GREEN Install discord? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install discord
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install telegram? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install telegram
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install google chrome stable? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install fedora-workstation-repositories
	sudo dnf config-manager --set-enabled google-chrome
	sudo dnf install google-chrome-stable
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install powertop? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo dnf install powertop
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi
