#!/bin/bash

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay/

sudo pacman -S dmidecode wget picocom lm_sensors neofetch tree man-db \
mesa lib32-mesa libva-mesa-driver lib32-libva-mesa-driver \
vulkan-icd-loader lib32-vulkan-icd-loader vulkan-radeon lib32-vulkan-radeon \
vulkan-tools mesa-demos clinfo libva-utils gnome dconf-editor gnome-tweaks \
xdg-desktop-portal xdg-desktop-portal-gtk networkmanager-openvpn pipewire \
lib32-pipewire pipewire-alsa pipewire-pulse pipewire-jack gst-plugin-pipewire \
gst-libav gstreamer-vaapi ttf-bitstream-vera ttf-fira-mono ttf-fira-code \
ttf-fira-sans ttf-dejavu ttf-liberation noto-fonts ttf-hack \
adobe-source-sans-pro-fonts ttf-droid ttf-inconsolata ttf-roboto \
ttf-roboto-mono ttf-opensans clang llvm electron python-pip vulkan-headers \
arm-none-eabi-gcc arm-none-eabi-newlib jdk8-openjdk jre8-openjdk \
chromium firefox telegram-desktop steam mpv transmission-gtk \
obs-studio gamemode lib32-gamemode kdenlive breeze breeze-gtk libvirt \
virt-manager qemu qemu-arch-extra edk2-ovmf iptables-nft dnsmasq \
wine-staging winetricks lib32-giflib lib32-libpng lib32-gnutls lib32-mpg123 \
lib32-openal lib32-v4l-utils lib32-libpulse lib32-libjpeg-turbo \
lib32-libxcomposite lib32-libxinerama lib32-opencl-icd-loader \
lib32-libxslt lib32-libva lib32-gtk3 lib32-gst-plugins-base-libs \
cups samba dosbox lutris

yay -S opencl-amd chrome-gnome-shell visual-studio-code-bin \
discord_arch_electron mangohud downgrade vgrep --noconfirm

sudo systemctl enable gdm
sudo systemctl enable libvirtd.service

echo "yay corectrl and protontricks"

