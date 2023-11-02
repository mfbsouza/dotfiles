#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'


echo ""
echo -e "$GREEN Installing Packages... $CLEAR"
echo ""

sudo pacman -S plasma dolphin kcalc ffmpegthumbs kdegraphics-thumbnailers \
	kate okular kwalletmanager spectacle alacritty libva-utils vdpauinfo \
	openresolv usb_modeswitch openssh openvpn wireguard-tools perl-json-xs \
	networkmanager-openvpn networkmanager-l2tp networkmanager-strongswan \
	bash-completion usbutils tmux neovim xclip xsel tree wget picocom \
	nasm valgrind htop rsync stress inxi rofi meson cmake clang llvm openmp \
	python-pip python-pylint lcov gperf help2man diffstat chrpath go gopls \
	rpcsvc-proto inetutils spirv-headers krita firefox transmission-qt \
	vlc mpv discord telegram-desktop obs-studio jre-openjdk wireshark-qt \
	docker virt-manager qemu-desktop dnsmasq iptables-nft filelight ark \
	dnsutils gwenview turbostat ethtool python-setuptools swtpm bear \
	nodejs npm noto-fonts noto-fonts-cjk noto-fonts-emoji dhcpcd net-tools \
	cpupower less nmap kdenlive
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo -e "$GREEN Install nvidia graphics packages? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S opencl-nvidia cuda nvidia-settings lib32-nvidia-utils
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
fi

echo -e "$GREEN Install amd graphics packages? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S mesa vulkan-radeon libva-mesa-driver opencl-mesa \
		lib32-vulkan-radeon
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
fi

echo -e "$GREEN Install intel graphics packages? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S mesa vulkan-intel intel-media-driver intel-compute-runtime \
		lib32-vulkan-intel
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
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

echo -e "$GREEN Install intel undervolt tool? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S intel-undervolt
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
fi

echo -e "$GREEN Install nvidia prime switch tool? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S nvidia-prime
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
fi

echo -e "$GREEN Install battery managment tools? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S tlp tlp-rdw
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
	echo -e "$GREEN enabling TLP service... $CLEAR"
	sudo systemctl enable tlp
	sudo systemctl enable NetworkManager-dispatcher.service
	sudo systemctl mask systemd-rfkill.service
	sudo systemctl mask systemd-rfkill.socket
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
echo -e "$GREEN Installing Visual Studio Code... $CLEAR"
echo ""
yay -S visual-studio-code-bin

echo ""
echo -e "$GREEN Installing Postman... $CLEAR"
echo ""
yay -S postman-bin

echo ""
echo -e "$GREEN Installing downgrade utility... $CLEAR"
echo ""
yay -S downgrade

echo ""
echo -e "$GREEN enabling systemd services... $CLEAR"
echo ""
sudo systemctl enable sddm
sudo systemctl enable bluetooth
sudo systemctl enable sshd
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
