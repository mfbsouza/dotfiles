#!/bin/bash

CONSOLE_TOOLS="bash-completion dmidecode vim neofetch wget picocom htop net-tools"
COMPRESSION_TOOLS="zip unzip unrar"
SERVICES="openssh xdg-user-dirs gvfs"
BLUE_SERVICE="bluez bluez-libs bluez-utils pulseaudio-bluetooth"
SOUND_SYSTEM="alsa-utils alsa-plugins pulseaudio pulseaudio-alsa libcanberra libcanberra-pulse"
XORG="xorg xorg-xinit"
FONTS="ttf-bitstream-vera ttf-dejavu ttf-liberation noto-fonts ttf-hack ttf-ubuntu-font-family adobe-source-sans-pro-fonts cantarell-fonts ttf-droid ttf-inconsolata ttf-roboto ttf-roboto-mono ttf-opensans"
INTEL="mesa lib32-mesa mesa-demos vulkan-intel lib32-vulkan-intel libva-intel-driver libva-utils intel-gpu-tools"
AMD="mesa lib32-mesa mesa-demos xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver libva-utils"
NVIDIA="nvidia nvidia-utils lib32-nvidia-utils nvidia-settings"
VULKAN_SUPPORT="vulkan-icd-loader lib32-vulkan-icd-loader vulkan-headers vulkan-validation-layers vulkan-tools"
DEV="go clang llvm cmake openmp python-pip linux-headers sdl2 sdl2_gfx sdl2_image sdl2_mixer sdl2_net sdl2_ttf"
XFCE="xfce4 mousepad ristretto file-roller thunar-archive-plugin thunar-media-tags-plugin xfce4-battery-plugin xfce4-datetime-plugin xfce4-notifyd xfce4-pulseaudio-plugin pavucontrol xfce4-screensaver xfce4-screenshooter xfce4-sensors-plugin xfce4-taskmanager xfce4-xkb-plugin gnome-keyring network-manager-applet nm-connection-editor materia-gtk-theme papirus-icon-theme"
LIGHTDM="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings"
PROGRAMS="firefox telegram-desktop vlc mpv obs-studio discord blender transmission-gtk"
JAVA="jre8-openjdk jdk8-openjdk"
VIRT="qemu libvirt virt-manager ebtables dnsmasq"

VIDEO=""
DM=""
DE=""

read -p "Arch Linux Pos install Script by github.com/mfbsouza. Continue [y,n]: " IN
if [ "$IN" == "n" ]; then
	exit
fi

read -p "Install bluetooth packages? [y,n]: " IN
if [ "$IN" == "n" ]; then
	BLUE_SERVICE=""
fi

read -p "Install Intel GPU Drivers? [y,n]: " IN
if [ "$IN" == "y" ]; then
	VIDEO="${INTEL}"
fi

read -p "Install AMD GPU Drivers? [y,n]: " IN
if [ "$IN" == "y" ]; then
	VIDEO="${VIDEO} ${AMD}"
fi

read -p "Install NVDIA GPU Drivers? [y,n]: " IN
if [ "$IN" == "y" ]; then
	VIDEO="${VIDEO} ${NVIDIA}"
fi

read -p "Choose your DE [xfce]: " IN
if [ "$IN" == "xfce" ]; then
	DE="${XFCE}"
fi

read -p "Choose your DM [lightdm]: " IN
if [ "$IN" == "lightdm" ]; then
	DM="${LIGHTDM}"
fi

sudo pacman -S $COMPRESSION_TOOLS $SERVICES $BLUE_SERVICE $SOUND_SYSTEM $XORG $FONTS $VIDEO $VULKAN_SUPPORT $DEV $DE $DM $PROGRAMS $JAVA $VIRT

read -p "Install YAY Package Manager? [y.n]: " IN
if [ "$IN" == "y" ]; then
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	rm -rf yay
fi

sudo systemctl enable sshd.service lightdm.service
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
sudo localectl set-x11-keymap br abnt2
