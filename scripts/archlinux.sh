#!/bin/bash

echo "Installing Console Tools"
sudo pacman -S bash-completion dmidecode vim neofetch wget picocom htop --noconfirm

echo "Installing Console Compression Tools"
sudo pacman -S zip unzip unrar --noconfirm

echo "Installing Console Network Tools"
sudo pacman -S rsync traceroute bind-tools net-tools --noconfirm

echo "Installing Services"
sudo pacman -S openssh xdg-user-dirs --noconfirm
sudo systemctl enable sshd.service

echo "Installing Bluetooth Service"
sudo pacman -S bluez bluez-libs bluez-utils --noconfirm
sudo systemctl enable bluetooth.service

echo "Installing File System Support"
sudo pacman -S gvfs --noconfirm

echo "Installing System Sound Packages"
sudo pacman -S alsa-utils alsa-plugins pulseaudio-alsa pulseaudio-bluetooth --noconfirm

echo "Installing X11 Packages"
sudo pacman -S xorg xorg-xinit --noconfirm

echo "Installing Xorg Default Fonts"
sudo pacman -S font-bh-ttf font-bitstream-speedo gsfonts ttf-bitstream-vera\
	ttf-dejavu ttf-liberation xorg-fonts-type1 --noconfirm

echo "Installing TTF Fonts"
sudo pacman -S noto-fonts ttf-hack ttf-ubuntu-font-family adobe-source-sans-pro-fonts\
	cantarell-fonts terminus-font ttf-droid ttf-inconsolata ttf-roboto ttf-opensans --noconfirm

sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d

echo "Installing Intel Graphics drivers..."
sudo pacman -S mesa lib32-mesa mesa-demos vulkan-intel libva-intel-driver libva-utils\
	intel-compute-runtime --noconfirm

echo "Installing Nvidia Graphics drivers..."
sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings\
	opencl-nvidia ocl-icd opencl-headers --noconfirm

echo "Installing Vulkan Support"
sudo pacman -S vulkan-icd-loader lib32-vulkan-icd-loader\
	vulkan-headers vulkan-validation-layers vulkan-tools --noconfirm

echo "Installing Developer Packages"
sudo pacman -S go clang cmake llvm openmp python-pip linux-headers sdl2 sdl2_gfx\
	sdl2_image sdl2_mixer sdl2_net sdl2_ttf --noconfirm

echo "Installing AUR Package manager"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

echo "Installing Cinnamon Desktop"
sudo pacman -S cinnamon blueberry ffmpegthumbnailer nemo-fileroller gnome-keyring xed\
	evince termite system-config-printer --noconfirm

## echo "Installing Openbox & Desktop Applications"
#sudo pacman -S openbox obconf lxinput lxrandr lxappearance tint2 --noconfirm
#mkdir -p ~/.config/openbox
#cp -a /etc/xdg/openbox/. ~/.config/openbox/

#sudo pacman -S pcmanfm xarchiver\
#	termite leafpad nitrogen\
#	nm-connection-editor network-manager-applet\
#	pasystray pavucontrol\
#	blueman --noconfirm

echo "Installing Personal Programs"
sudo pacman -S telegram-desktop vlc mpv obs-studio transmission-gtk discord blender --noconfirm
yay -S visual-studio-code-bin spotify --noconfirm

echo "Installing JAVA 8"
sudo pacman -S jre8-openjdk jdk8-openjdk --noconfirm

echo "Installing Virtualization Tools"
sudo pacman -S qemu ovmf libvirt virt-manager ebtables dnsmasq --noconfirm
sudo systemctl enable libvirtd.service ebtables.service dnsmasq.service
