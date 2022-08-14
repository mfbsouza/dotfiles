# My Pop OS workstation install step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Pop OS ISO

i go with the defaults and dont encrypt

## Setting up the base system

#### Update the system packages

open Pop!_Shop update the packages then reboot


#### configure Gnome Desktop

- Open settings and go tab by tab

also:

	$ gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'

#### Add boot parameter for disabling Audit (optional)

	$ sudo kernelstub -a "audit=0"
	$ sudo kernelstub -p

#### Add boot parameter for AMDGPU tweaking (optional)

	$ sudo kernelstub -a "amdgpu.ppfeaturemask=0xffffffff"
	$ sudo kernelstub -p

Reboot

## Setting up the basic system tools

#### Codecs

	$ sudo apt install ubuntu-restricted-extras ffmpegthumbnailer

#### Development tools

	$ sudo apt install vim-gtk ack screen autoconf automake gperf texinfo \
	help2man libtool libtool-bin gawk libncurses-dev meson ninja-build \
	clang llvm clang-format python3-pip cmake bear tree universal-ctags \
	nasm qemu-system-x86 qemu-system-misc valgrind

#### ADM tools

	$ sudo apt install lm-sensors neofetch htop stress inxi

#### Torrent Client and Video Player

	$ sudo apt install transmission-gtk vlc

#### Vulkan Headers and Tools

	$ sudo apt install libvulkan-dev vulkan-tools mesa-utils 

#### GPU VAAPI debug

	$ sudo apt install vainfo

#### SSH Server

	$ sudo apt install openssh-server

#### avr cross-compiler, binutils and tools

	$ sudo apt install gcc-avr avr-libc gdb-avr avrdude
	$ sudo usermod -a -G dialout <username>

#### L2TP Network Manager VPN support

	$ sudo apt install network-manager-l2tp network-manager-l2tp-gnome

#### Java

	$ sudo apt install default-jre default-jdk

#### Steam

	$ sudo apt install gamemode mangohud vkbasalt steam

#### Configure Git (optional)

	$ git config --global user.name "username"
	$ git config --global user.email "user@email.com"
	$ git config --global core.editor "editor"
	$ git config --global credential.helper store

## Optional Tweaks

#### intel GPU Enable performance support

	$ echo dev.i915.perf_stream_paranoid=0 | sudo tee -a /etc/sysctl.d/99-i915psp.conf

## Desktop Applications

for desktop applications i use Flatpak

- OBS Studio
- Discord
- Telegram
- Helvum
- EasyEffects

#### TLDR

	sudo apt install vim-gtk screen autoconf automake gperf texinfo help2man \
	libtool libtool-bin gawk libncurses-dev meson ninja-build clang llvm \
	clang-format python3-pip cmake tree universal-ctags nasm qemu-system-x86 \
	qemu-system-misc valgrind ubuntu-restricted-extras ffmpegthumbnailer \
	lm-sensors neofetch htop stress transmission-gtk vlc libvulkan-dev \
	vulkan-tools mesa-utils vainfo openssh-server gcc-avr gdb-avr avr-libc \
	avrdude network-manager-l2tp network-manager-l2tp-gnome gamemode mangohud \
	vkbasalt steam

