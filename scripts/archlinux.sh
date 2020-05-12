#!/bin/bash
read -p "Arch Linux Pos Install Script by github.com/mfbsouza. Continue? [y,n]: " USER_INPUT
if [ "$USER_INPUT" == "n" ]; then
	exit
fi

echo "Installing Console Tools"
sudo pacman -S bash-completion dmidecode vim neofetch wget picocom htop --noconfirm

echo "Installing Console Compression Tools"
sudo pacman -S zip unzip unrar --noconfirm

echo "Installing Console Network Tools"
sudo pacman -S rsync traceroute bind-tools net-tools --noconfirm

echo "Installing Services"
sudo pacman -S openssh xdg-utils xdg-user-dirs --noconfirm
sudo systemctl enable sshd.service

read -p "Install Blutooth Services? [y,n]: " USER_INPUT
if [ "$USER_INPUT" == "y" ]; then
	sudo pacman -S bluez bluez-libs bluez-utils blueman --noconfirm
	sudo systemctl enable bluetooth.service
fi

echo "Installing File System Support"
sudo pacman -S gvfs --noconfirm

echo "Installing System Sound Packages"
sudo pacman -S alsa-utils alsa-plugins\
	pulseaudio pulseaudio-alsa pulseaudio-bluetooth\
       libcanberra libcanberra-pulse --noconfirm

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

read -p "Install Intel Graphics drivers? [y,n]: " USER_INPUT
if [ "$USER_INPUT" == "y" ]; then
	sudo pacman -S mesa lib32-mesa mesa-demos vulkan-intel libva-intel-driver\
	libva-utils intel-compute-runtime --noconfirm
fi

read -p "Install AMD Open Source Graphics Drivers? [y,n]: " USER_INPUT
if [ "$USER_INPUT" == "y" ]; then
	sudo pacman -S mesa lib32-mesa mesa-demos xf86-video-amdgpu\
	vulkan-radeon lib32-vulkan-radeon vulkan-mesa-layer\
	libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau --noconfirm
fi

read -p "Install AMD OpenCL Drivers? [y,n]: " USER_INPUT
if [ "$USER_INPUT" == "y" ]; then
	yay -S opencl-amd --noconfirm
	sudo pacman -S ocl-icd opencl-headers --noconfirm
fi

read -p "Install Nvidia Graphics drivers? [y,n]: " USER_INPUT
if [ "$USER_INPUT" == "y" ]; then
	sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings --noconfirm
fi

read -p "Install Nvidia CUDA Packages? [y,n]: " USER_INPUT
if [ "$USER_INPUT" == "y" ]; then
	sudo pacman -S opencl-nvidia ocl-icd opencl-headers cuda --noconfirm
fi

read -p "Install Vulkan Support? [y,n]: " USER_INPUT
if [ "$USER_INPUT" == "y" ]; then
	sudo pacman -S vulkan-icd-loader lib32-vulkan-icd-loader\
	vulkan-headers vulkan-validation-layers vulkan-tools --noconfirm
fi

echo "Installing Developer Packages"
sudo pacman -S go clang cmake llvm openmp python-pip linux-headers sdl2 sdl2_gfx\
	sdl2_image sdl2_mixer sdl2_net sdl2_ttf --noconfirm

echo "Installing AUR Package manager"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

read -p "Install Openbox & Desktop Applications? [y,n]: " USER_INPUT
if [ "$USER_INPUT" == "y" ]; then
	sudo pacman -S openbox obconf lxappearance lxhotkey tint2\
	pcmanfm xarchiver termite leafpad nitrogen gnome-keyring\
	nm-connection-editor network-manager-applet pasystray pavucontrol --noconfirm
	
	yay -S powerkit --noconfirm
	sudo systemctl enable upower.service
	sudo usermod -aG video $USER
fi

echo "Configuring X11 Keyboard and Touchpad"
sudo localectl set-x11-keymap br abnt2
sudo cp ../etc/X11/xorg.conf.d/30-touchpad.conf /etc/X11/xorg.conf.d/

echo "Installing Personal Programs"
sudo pacman -S telegram-desktop vlc mpv obs-studio transmission-gtk discord blender --noconfirm
yay -S visual-studio-code-bin spotify --noconfirm

echo "Installing JAVA 8"
sudo pacman -S jre8-openjdk jdk8-openjdk --noconfirm

echo "Installing Virtualization Tools"
sudo pacman -S qemu ovmf libvirt virt-manager ebtables dnsmasq --noconfirm
sudo systemctl enable libvirtd.service ebtables.service dnsmasq.service
