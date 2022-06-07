# My Fedora Linux netinstall step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Fedora Netinstall ISO

I go with the minimal install plus common standard utilities and C development tools

## Fedora Netinstall setup

### Enable RPM Fusion

	$ sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

	$ sudo dnf update --refresh

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
