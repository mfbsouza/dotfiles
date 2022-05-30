# My Fedora Linux install step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Enable RPM Fusion

for both install methods first thing to do is enable rpm fusion

	$ sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

## Install

- [Fedora Workstation](#fedora-workstation)
- [Fedora Netinstall](#fedora-netinstall)

## Fedora Workstation

i go with the defaults. anaconda installer it's pretty straight foward
- [Fedora Workstation setup](#fedora-workstation-setup)

## Fedora Netinstall

I go with the minimal install plus common standard utilities and C development tools
- [Fedora Netinstall setup](#fedora-netinstall-setup)

## Fedora Netinstall setup

	$ sudo dnf update

### Installing base xorg packages and pipewire

	$ sudo dnf install @base-x xorg-x11-xinit setxkbmap xkill pipewire

user directories

	$ sudo dnf install xdg-user-dirs
	$ xdg-user-dirs-update

### dwm window manager

	$ sudo dnf install git
	$ git clone https://git.suckless.org/dwm
	$ git clone https://git.suckless.git/st

program launcher

	$ sudo dnf install dmenu

file browser

	$ sudo dnf install pcmanfm gvfs file-roller

applets

	$ sudo dnf install network-manager-applet NetworkManager-openvpn pasystray pavucontrol

compile dependecies

	$ sudo dnf install libX11-devel libXinerama-devel libXft-devel libXext-devel

install dwm and st

	$ cd dwm/ or st/
	$ make
	$ sudo make install

configure .xinitrc

	$ vi ~/.xinitrc
	setxkbmap -layout "br"
	xrandr --output Virtual-0 --mode 1920x1080 --rate 60
	exec dwm

now can go foward with the "fedora workstation setup" after steps

## Fedora Workstation setup

- I don't enable the Thirdy Party Repositories
- Disable automatic updates in Software > Update Preferences
- Disable wayland in /etc/gdm/custom.conf
- Reboot

configure gnome

	$ ./workspace/dotfiles/scripts/gnome-settings.sh

### Enable Custom Kernel

	$ sudo dnf copr enable sentry/kernel-fsync

if you don't want any official Fedora kernels and only use this one edit `/etc/yum.repos.d/fedora-updates.repo` and add: `exclude=kernel*` to the bottom of the `[updates]` section.

### Enable Mesa-git

	$ sudo dnf copr enable gloriouseggroll/mesa-aco

### Enable game-utils

	$ sudo dnf copr enable gloriouseggroll/game-utils

### Update the system

	$ sudo dnf update --refresh

Reboot

### Remove old kernels

	$ rpm -q kernel-core
	$ sudo dnf remove kernel-core-5.14.10-300.fc35.x86_64

### Add boot parameter for disabling SElinux and Audit

	# grubby --args=selinux=0 --update-kernel /boot/vmlinuz-$(uname -r)
	# grubby --args=audit=0 --update-kernel /boot/vmlinuz-$(uname -r)
	# grubby --info /boot/vmlinuz-$(uname -r)

### Add boot parameter for AMDGPU tweaking (optional)

	# grubby --args=amdgpu.ppfeaturemask=0xffffffff --update-kernel /boot/vmlinuz-$(uname -r)
	# grubby --info /boot/vmlinuz-$(uname -r)

### Add boot parameter for intel tweaking (optional)

	# grubby --args=i915.fastboot=1 --update-kernel /boot/vmlinuz-$(uname -r)
	# grubby --info /boot/vmlinuz-$(uname -r)

reboot

### Install RPM Fusion AppStream metadata

	$ sudo dnf groupupdate core

### Install Multimedia codecs

	$ sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin


### Developement tools

	$ sudo dnf install git vim ack screen

### ADM tools

	$ sudo dnf install htop lm_sensors neofetch kernel-tools kernel-devel inxi

### Compilers, libraries and tools

general

	$ sudo dnf install autoconf gperf texinfo help2man libtool patch ncurses-devel perl-Thread-Queue meson ninja-build python3-pip cmake gcc-c++ python3-devel bear perl NetworkManager-l2tp NetworkManager-l2tp-gnome NetworkManager-strongswan fail2ban

intel VAAPI

	$ sudo dnf install libva-utils intel-media-driver
	$ echo "LIBVA_DRIVER_NAME=iHD" | sudo tee -a /etc/environment

Firefox VAAPI workaround

	$ echo "MOZ_DISABLE_RDD_SANDBOX=1" | sudo tee -a /etc/environment

intel GPGPU (Not working right now)

	$ sudo dnf install intel-compute-runtime clinfo

avr and arm compilers & tools

	$ sudo dnf install arm-none-eabi-gcc avr-gcc avr-lib avrdude

vulkan

	$ sudo dnf install vulkan-headers vulkan-tools

### vim's Vundle and YCM

	$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

open vim and do a ":PlugInstall" then exit

	$ cd ~/.vim/bundle/YouCompleteMe
	$ python3 install.py --clangd-completer

### desktop programs

	$ sudo dnf install vlc transmission-gtk obs-studio mangohud vkBasalt gamescope steam

### Enable CPUPOWER for Performance governor (optional)

	$ sudo systemctl enable --now cpupower
	$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

### Virtualization

	$ sudo dnf group install --with-optional virtualization
	$ sudo dnf install qemu-system-arm qemu-system-aarch64 qemu-system-riscv
	$ sudo systemctl enable --now libvirtd

**Done with the basic. Now Reboot**

### configure Git

	$ git config --global user.name "username"
	$ git config --global user.email "user@email.com"
	$ git config --global core.editor "editor"
	$ git config --global credential.helper store
