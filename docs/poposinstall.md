# My Pop OS workstation install step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Pop OS ISO

i go with the defaults and dont encrypt

## Setting up the base system

#### Update the system packages

	$ sudo apt update && sudo apt upgrade

reboot

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

#### Development tools

	$ sudo apt install vim-gtk3 ack screen autoconf automake gperf texinfo \
	help2man libtool libtool-bin gawk libncurses-dev meson ninja-build \
	python3-pip cmake python3-dev bear tree universal-ctags nasm qemu-system-x86

#### Codecs

	$ sudo apt install ubuntu-restricted-extras ffmpegthumbnailer

#### ADM tools

	$ sudo apt install htop lm-sensors neofetch inxi

#### Torrent Client and Video Player

	$ sudo apt install transmission-gtk vlc

#### L2TP Network Manager VPN support (optional)

	$ sudo apt install network-manager-l2tp network-manager-l2tp-gnome

#### Vulkan Headers and Tools (optional)

	$ sudo apt install libvulkan-dev vulkan-tools

#### Java (optional)

	$ sudo apt install default-jre default-jdk

#### avr cross-compiler, binutils and tools (optional)

	$ sudo aptt install gcc-avr avr-libc avrdude
	$ sudo usermod -a -G dialout <username>

#### Configure Git (optional)

	$ git config --global user.name "username"
	$ git config --global user.email "user@email.com"
	$ git config --global core.editor "editor"
	$ git config --global credential.helper store

## Optional Tweaks

#### intel GPU VAAPI support

	$ sudo apt install vainfo

#### intel GPU Enable performance support

	$ echo dev.i915.perf_stream_paranoid=0 | sudo tee -a /etc/sysctl.d/99-i915psp.conf

## Desktop Applications

for desktop applications i use Flatpak

- OBS Studio
- Discord
- Telegram
- Helvum
- EasyEffects

#### Steam

	$ sudo apt install gamemode mangohud vkbasalt steam

#### TLDR

	sudo apt install vim-gtk screen autoconf automake gperf texinfo help2man libtool \
	libtool-bin gawk libncurses-dev meson ninja-build clang llvm clang-format \
	python3-pip cmake universal-ctags nasm qemu-system-x86 ubuntu-restricted-extras \
	ffmpegthumbnailer lm-sensors neofetch mesa-utils htop transmission-gtk vlc \
	libvulkan-dev vulkan-tools vainfo gcc-avr avr-libc avrdude network-manager-l2tp \
	network-manager-l2tp-gnome gamemode mangohud vkbasalt tree steam

