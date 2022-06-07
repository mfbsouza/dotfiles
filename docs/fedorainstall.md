# My Fedora Linux workstation install step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Fedora Workstation ISO

i go with the defaults. anaconda installer it's pretty straight foward

## Setting up the base system

- I don't enable the Thirdy Party Repositories
- Disable automatic updates in Software > Update Preferences

**Reboot**

configure Gnome Desktop (optional)

	$ ./workspace/dotfiles/scripts/gnome-settings.sh

#### Enable RPM fusion

	$ sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#### Enable Custom Kernel (optional)

	$ sudo dnf copr enable sentry/kernel-fsync

if you don't want any official Fedora kernels and only use this one edit `/etc/yum.repos.d/fedora-updates.repo` and add: `exclude=kernel*` to the bottom of the `[updates]` section.

#### Enable Mesa-git (optional)

	$ sudo dnf copr enable gloriouseggroll/mesa-aco

#### Update the system packages

	$ sudo dnf update --refresh

Reboot

#### Remove old kernels (optional)

	$ rpm -q kernel-core
	$ sudo dnf remove kernel-core-5.14.10-300.fc35.x86_64

#### Add boot parameter for disabling SElinux and Audit (optional)

	# grubby --args=selinux=0 --update-kernel /boot/vmlinuz-$(uname -r)
	# grubby --args=audit=0 --update-kernel /boot/vmlinuz-$(uname -r)
	# grubby --info /boot/vmlinuz-$(uname -r)

#### Add boot parameter for AMDGPU tweaking (optional)

	# grubby --args=amdgpu.ppfeaturemask=0xffffffff --update-kernel /boot/vmlinuz-$(uname -r)
	# grubby --info /boot/vmlinuz-$(uname -r)

#### Add boot parameter for intel GPU tweaking (optional)

	# grubby --args=i915.fastboot=1 --update-kernel /boot/vmlinuz-$(uname -r)
	# grubby --info /boot/vmlinuz-$(uname -r)

Reboot

## Setting up the basic system tools

#### RPM Fusion AppStream metadata

	$ sudo dnf groupupdate core

#### Multimedia codecs

	$ sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

#### Development tools

	$ sudo dnf install git vim ack screen autoconf gperf texinfo help2man libtool patch ncurses-devel meson ninja-build python3-pip cmake gcc-c++ python3-devel bear perl perl-Thread-Queue kernel-devel

#### ADM tools

	$ sudo dnf install htop lm_sensors neofetch kernel-tools inxi

#### Vulkan Headers and Tools (optional)

	$ sudo dnf install vulkan-headers vulkan-tools

#### L2TP Network Manager VPN support (optional)

	$ sudo dnf install NetworkManager-l2tp NetworkManager-l2tp-gnome NetworkManager-strongswan

#### Security for SSH login outside of local network (optional)

	$ sudo dnf install fail2ban

#### AVR and ARM cross-compiler and tools (optional)

	$ sudo dnf install arm-none-eabi-gcc avr-gcc avr-lib avrdude

#### Configure Git (optional)

	$ git config --global user.name "username"
	$ git config --global user.email "user@email.com"
	$ git config --global core.editor "editor"
	$ git config --global credential.helper store

## Optional Tweaks

#### Firefox VAAPI error workaround

	$ echo "MOZ_DISABLE_RDD_SANDBOX=1" | sudo tee -a /etc/environment

#### intel GPU VAAPI support

	$ sudo dnf install libva-utils intel-media-driver
	$ echo "LIBVA_DRIVER_NAME=iHD" | sudo tee -a /etc/environment

#### intel GPU Enable performance support

	$ echo dev.i915.perf_stream_paranoid=0 | sudo tee -a /etc/sysctl.d/99-i915psp.conf

#### intel GPGPU support (Not working right now)

	$ sudo dnf install intel-compute-runtime clinfo

#### vim's Vundle and YCM

	$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

install the .vimrc config file and open vim and do a ":PlugInstall" then exit

	$ cd ~/.vim/bundle/YouCompleteMe
	$ python3 install.py --clangd-completer

#### Enable CPUPOWER for Performance governor

	$ sudo systemctl enable --now cpupower
	$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

Reboot

## Desktop Programs

	$ sudo dnf install vlc transmission-gtk obs-studio mangohud vkBasalt gamescope steam

#### Virt Manager

	$ sudo dnf group install --with-optional virtualization
	$ sudo dnf install qemu-system-arm qemu-system-aarch64 qemu-system-riscv
	$ sudo systemctl enable --now libvirtd
