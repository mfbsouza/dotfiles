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
	$ gsettings set org.gnome.Terminal.Legacy.Settings headerbar false

#### configure enviroment variables

at the end of the `.bashrc` file:

	# env
	export WORKSPACE=$HOME/workspace
	export CPPUTEST_HOME=$WORKSPACE/cpputest
	export GOPATH=$HOME/.go
	export PATH=$PATH:$GOPATH/bin

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

#### Dev tools

	$ sudo apt install xclip ack picocom autoconf automake gperf texinfo \
	help2man libtool libtool-bin gawk libncurses-dev meson ninja-build \
	clang llvm clang-format python3-pip cmake bear tree cscope nasm \
	qemu-system-x86 qemu-system-misc valgrind tmux clangd lcov \
	golang golang-golang-x-tools docker.io qtcreator diffstat chrpath socat \
	python3-pexpect python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
	pylint xterm python3-subunit mesa-common-dev liblz4-tool

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

#### L2TP Network Manager VPN support

	$ sudo apt install network-manager-l2tp network-manager-l2tp-gnome

#### Java

	$ sudo apt install default-jre default-jdk

#### Graphical Libraries

	$ sudo apt install libsdl2-dev libglew-dev libglm-dev libsdl2-image-dev

#### Gamming

	$ sudo apt install mangohud vkbasalt steam lutris

my launch options for Dota 2:
	
	ENABLE_VKBASALT=1 MANGOHUD=1 %command% -vulkan -novid -vulkan_disable_steam_shader_cache

## Optional Tweaks

#### intel GPU Enable performance support

	$ echo dev.i915.perf_stream_paranoid=0 | sudo tee -a /etc/sysctl.d/99-i915psp.conf

## Manual stuff

#### Install from .deb file:

- neovim
- ripgrep
- Teams
- AnyDesk
- Google Chrome

#### Configure Git (optional)

	$ git config --global user.name "username"
	$ git config --global user.email "user@email.com"
	$ git config --global core.editor "editor"
	$ git config --global credential.helper store

#### Add yourself to the dialout group

	$ sudo usermod -a -G dialout <username>

#### Add yourself to the docker group

	$ sudo usermod -a -G docker <username>

#### install Rust

	$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#### Rust Analyzer (install after Rust)

	$ curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.cargo/bin/rust-analyzer
	$ chmod +x ~/.cargo/bin/rust-analyzer

#### Go Language Server

	$ go install golang.org/x/tools/gopls@latest

#### Lua Language Server

	$ git clone  --depth=1 https://github.com/sumneko/lua-language-server
	$ cd lua-language-server
	$ git submodule update --depth 1 --init --recursive
	$ cd 3rd/luamake
	$ ./compile/install.sh
	$ cd ../..
	$ ./3rd/luamake/luamake rebuild

#### Install CppUTest

	$ git clone https://github.com/cpputest/cpputest
	$ cd cpputest
	$ autoreconf . -i
	$ ./configure
	$ make tdd -j$(nproc)

#### Install Inconsolata Nerd Fonts

download and extract the fonts and do:
	
	$ mkdir -p ~/.fonts
	$ cp -r . ~/.fonts
	$ fc-cache -fv

#### Install configuration files:

	./install.sh

#### TLDR

	sudo apt install xclip ack picocom autoconf automake gperf \
	texinfo help2man libtool libtool-bin gawk libncurses-dev \
	meson ninja-build clang llvm clang-format python3-pip cmake bear \
	bear tree cscope nasm qemu-system-x86 qemu-system-misc valgrind \
	ubuntu-restricted-extras ffmpegthumbnailer lm-sensors neofetch htop \
	transmission-gtk vlc libvulkan-dev vulkan-tools mesa-utils vainfo \
	openssh-server gcc-avr gdb-avr avr-libc avrdude network-manager-l2tp \
	network-manager-l2tp-gnome virt-manager obs-studio tmux clangd lcov \
	stress inxi golang golang-golang-x-tools code telegram-desktop discord \
	libsdl2-dev libglew-dev libglm-dev libsdl2-image-dev slack-desktop \
	docker.io qtcreator diffstat chrpath socat python3-pexpect python3-git \
	python3-jinja2 libegl1-mesa libsdl1.2-dev pylint xterm python3-subunit \
	mesa-common-dev liblz4-tool mangohud vkbasalt steam lutris

