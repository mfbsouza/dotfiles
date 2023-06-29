# arch system

## DE

### gnome

- gnome
- gnome-shell-extension-appindicator
- libappindicator-gtk3
- libappindicator-gtk2
- systemctl enable gdm

### plasma

- plasma
- dolphin
- ffmpegthumbs
- kdegraphics-thumbnailers
- kwalletmanager
- spectacle
- sudo systemctl enable sddm

## terminal

- alacritty

## bluetooth

- systemctl enable bluetooth

## nvidia gpu driver

- nvidia_drm.modeset=1
- nvidia nvidia_modeset nvidia_uvm nvidia_drm

## graphics, hw video acceleration and gpgpu

- libva-utils
- vdpauinfo

### nvidia

- opencl-nvidia
- cuda
- nvidia-settings

### intel

- mesa
- vulkan-intel
- intel-media-driver
- intel-compute-runtime

### amd

- mesa
- vulkan-radeon
- libva-mesa-driver
- opencl-mesa

## samba file sharing

## resolver

- systemd-resolvconf

## mobile internet

- usb_modeswitch

# ssh

- openssh
- systemctl enable sshd

## vpn

- openvpn
- wireguard-tools
- networkmanager-openvpn
- networkmanager-l2tp
- networkmanager-strongswan

## shell

- bash-completion

## usb

- usbutils

## dev/sysadmin

- git
- tmux
- neovim
- xclip
- xsel
- tree
- wget
- picocom
- nasm
- valgrind
- htop
- rsync
- stress
- inxi
- rofi

- meson
- cmake
- clang
- llvm
- openmp
- python-pip
- python-pylint
- go
- gopls
- lcov
- gperf
- help2man
- diffstat
- chrpath
- rpcsvc-proto
- inetutils
- spirv-headers

## drawing

- krita

## browser

- firefox

## torrent client

- trasmission-qt

## media player

- vlc
- mpv

## chat

- discord
- telegram-desktop

## streaming and recording

- obs-studio

## java

- jre-openjdk

## games

- mangohud
- vkbasalt (aur)
- steam
- wine-staging
- winetricks
- lutris

## packet analyzer

- wireshark-qt
- sudo usermod -a -G wireshark $USER

## container

- docker
- systemctl enable docker
- sudo usermod -a -G docker $USER

## serial user privilages

- sudo usermod -a -G uucp $USER

