# My Fedora Linux install step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Install

i go with the defaults. anaconda installer it's pretty straight foward

## Pos-install

- I don't enable the Thirdy Party Repositories
- Disable automatic updates in Software > Update Preferences
- Disable wayland in /etc/gdm/custom.conf
- Reboot

## Setting up the system

- Configure git:

	$ git config --global user.name "username"
	$ git config --global user.email "user@email.com"
	$ git config --global core.editor "editor"

- Configure Gnome:

	$ ./workspace/dotfiles/scripts/arch/gnome-settings.sh

- Enable RPM Fusion:

	$ sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

- Enable Custom Kernel:

	$ sudo dnf copr enable sentry/kernel-fsync

if you don't want any official Fedora kernels and only use this one edit `/etc/yum.repos.d/fedora-updates.repo` and add: `exclude=kernel*` to the bottom of the `[updates]` section.

- Enable Mesa-git:

	$ sudo dnf copr enable gloriouseggroll/mesa-aco

- Update the system:

	$ sudo dnf update --refresh

- Reboot

- Remove old kernels:

	$ rpm -q kernel-core
	$ sudo dnf remove kernel-core.5.14.10-300.fc35.x86_64

- Install kernel devel:

	$ sudo dnf install kernel-devel

- Install RPM Fusion AppStream metadata:

	$ sudo dnf groupupdate core

- Install Multimedia codecs:

	$ sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

- Install programs and utilities:

	$ ./workspace/dotfiles/scripts/fedora/utilities.sh
	$ ./workspace/dotfiles/scripts/fedora/toolchains.sh
	$ ./workspace/dotfiles/scripts/fedora/de-programs.sh

- Configure WirePlumber bug with the Logitech C270 webcam:

	$ sudo dnf install pavucontrol (remove de pro mode in the configs, set it to mono)

configure the microphone volume in the gnome settings

- Configure sensors and fancontrol:

	# sensors-detect
	# pwmconfig (mintemp=47 maxtemp=76)
	$ sudo systemctl enable --now fancontrol.service

- Enable CPUPOWER for Performance governor:

	$ sudo systemctl enable --now cpupower
	$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

**Done with the basic. Now Reboot**

- Enable Git credentials

	$ git config --global credential.helper store

- Configure Steam Play

	$ pip install protonup
	$ mkdir -p ~/.steam/root/compatibilitytools.d/
	$ protonup -d "~/.steam/root/compatibilitytools.d/"
	$ protonup
