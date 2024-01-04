#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'


echo ""
echo -e "$GREEN Installing Packages... $CLEAR"
echo ""

sudo pacman -S xorg-server xorg-xinit xorg-xinput xorg-setxkbmap \
	xorg-xrandr xorg-xkill xorg-xbacklight xsel xclip noto-fonts \
	noto-fonts-cjk noto-fonts-emoji ttf-liberation ttf-inconsolata-nerd \
	wget unzip htop usbutils rsync less fzf fastfetch i3 j4-dmenu-desktop \
	feh picom xdg-utils xdg-user-dirs blueman bluez-utils gnome-keyring \
	dmenu alacritty tmux gdb fd ripgrep go rustup firefox flatpak mpv \
	lxrandr pcmanfm lxappearance materia-gtk-theme papirus-icon-theme \
	gvfs xarchiver udiskie bash-completion ethtool smartmontools \
	pavucontrol ffmpegthumbnailer gst-libav gst-plugins-ugly xss-lock \
	libva-utils gpicview xdotool maim brightnessctl transmission-gtk \
	cpupower docker wireshark-qt virt-manager qemu-desktop jre-openjdk \
	xdg-desktop-portal-gtk nm-connection-editor dbeaver \
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo ""
echo -e "$GREEN Installing rust default toolchain... $CLEAR"
echo ""

rustup default stable
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo -e "$GREEN Install nvidia graphics packages? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S opencl-nvidia cuda nvidia-utils libva-nvidia-driver
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
fi

echo -e "$GREEN Install nvidia lib32 packages and nvidia settings? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S nvidia-settings lib32-nvidia-utils
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
	sudo pacman -S mesa vulkan-radeon libva-mesa-driver opencl-mesa
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
fi

echo -e "$GREEN Install amdgpu lib32 packages? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S lib32-vulkan-radeon
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
		intel-gpu-tools
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
fi

echo -e "$GREEN Install intel graphics lib32 packages? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo pacman -S lib32-vulkan-intel
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

echo -e "$GREEN Set cpu to performance governor? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	sudo sed -i "s/#governor='ondemand'/governor='performance'/g" \
		/etc/default/cpupower
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
	echo -e "$GREEN enabling cpupower service... $CLEAR"
	sudo systemctl enable cpupower.service
fi

echo ""
echo -e "$GREEN Installing yay... $CLEAR"
echo ""
 git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
 cd /tmp/yay-bin
 makepkg -si
 cd -

echo ""
echo -e "$GREEN Installing downgrade utility... $CLEAR"
echo ""
yay -S downgrade

echo ""
echo -e "$GREEN enabling systemd services... $CLEAR"
echo ""
sudo systemctl enable systemd-resolved
sudo systemctl enable bluetooth
sudo systemctl enable sshd
sudo systemctl enable docker
sudo systemctl enable libvirtd

echo ""
echo -e "$GREEN Adding user to groups... $CLEAR"
echo ""

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

sudo usermod -a -G wireshark $USER
if [ "$?" -ne 0 ]; then
	echo ""
	echo -e "$RED Something went wrong! Stopping... $CLEAR"
	echo ""
	exit 1
fi

echo -e "$GREEN flatpak apps? [y/n] $CLEAR"
read ANSWER
if [ "$ANSWER" == "y" ]; then
	flatpak install discord zoom
	if [ "$?" -ne 0 ]; then
		echo ""
		echo -e "$RED Something went wrong! Stopping... $CLEAR"
		echo ""
		exit 1
	fi
fi

echo ""
echo -e "$GREEN Done! $CLEAR"
echo ""
exit 0
