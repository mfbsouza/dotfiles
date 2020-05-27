#!/bin/bash

CONSOLE_TOOLS="bash-completion dmidecode vim neofetch wget picocom htop net-tools"
COMPRESSION_TOOLS="zip unzip unrar"
SERVICES="openssh xdg-user-dirs gvfs"
BLUE_SERVICE="bluez bluez-libs bluez-utils pulseaudio-bluetooth"
SOUND_SYSTEM="alsa-utils alsa-plugins pulseaudio pulseaudio-alsa libcanberra libcanberra-pulse"
XORG="xorg-server"
FONTS="ttf-bitstream-vera ttf-dejavu ttf-liberation noto-fonts ttf-hack ttf-ubuntu-font-family adobe-source-sans-pro-fonts cantarell-fonts ttf-droid ttf-inconsolata ttf-roboto ttf-roboto-mono ttf-opensans"
INTEL="mesa lib32-mesa mesa-demos vulkan-intel lib32-vulkan-intel libva-intel-driver libva-utils intel-gpu-tools"
AMD="mesa lib32-mesa mesa-demos vulkan-radeon lib32-vulkan-radeon libva-mesa-driver libva-utils"
NVIDIA="nvidia nvidia-utils lib32-nvidia-utils nvidia-settings"
VULKAN_SUPPORT="vulkan-icd-loader lib32-vulkan-icd-loader vulkan-headers vulkan-validation-layers vulkan-tools"
DEV="go clang llvm cmake openmp python-pip linux-headers sdl2 sdl2_gfx sdl2_image sdl2_mixer sdl2_net sdl2_ttf"
PLASMA="plasma-desktop powerdevil plasma-nm plasma-pa ark konsole dolphin kinfocenter spectacle okular gwenview kwrite dolphin-plugins kdegraphics-thumbnailers ffmpegthumbs user-manager xdg-desktop-portal-kde kde-gtk-config breeze-gtk kscreen kcalc"
XFCE="xfce4 mousepad ristretto file-roller thunar-archive-plugin thunar-media-tags-plugin xfce4-battery-plugin xfce4-datetime-plugin xfce4-notifyd xfce4-pulseaudio-plugin pavucontrol xfce4-screensaver xfce4-screenshooter xfce4-sensors-plugin xfce4-taskmanager xfce4-xkb-plugin gnome-keyring network-manager-applet nm-connection-editor xfce4-whiskermenu-plugin"
MATE="mate mate-extra mate-media system-config-printer gtk-engines gtk-engine-murrine network-manager-applet nm-connection-editor gnome-keyring"
OPENBOX="openbox obconf lxappearance lxhotkey tint2 pcmanfm xarchiver termite leafpad nitrogen gnome-keyring nm-connection-editor network-manager-applet pasystray pavucontrol"
GNOME="cheese eog evince file-roller gedit gnome-backgrounds gnome-calculator gnome-color-manager gnome-control-center gnome-disk-utility gnome-keyring gnome-logs gnome-menus gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-system-monitor gnome-terminal gnome-todo gnome-user-share gnome-video-effects grilo-plugins gvfs-google gvfs-nfs mutter nautilus rygel sushi xdg-user-dirs-gtk dconf-editor gnome-tweaks gtk-engines gtk-engine-murrine"
SDDM="sddm sddm-kcm"
LIGHTDM="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings"
JAVA="jre8-openjdk"
VIRT="qemu libvirt virt-manager ebtables dnsmasq"

VIDEO=""
DM=""
DE=""
PROGRAMS=""

read -p "Arch Linux Pos install Script by github.com/mfbsouza. Continue [y,n]: " IN
if [ "$IN" == "n" ]; then
	exit
fi

read -p "Install Bluetooth packages and front-end? [blueman,blueberry,bluedevil,nofront,noblue]: " IN
if [ "$IN" == "blueman" ]; then
	BLUE_SERVICE="${BLUE_SERVICE} blueman"
elif [ "$IN" == "blueberry" ]; then
	BLUE_SERVICE="${BLUE_SERVICE} blueberry"
elif [ "$IN" == "bluedevil" ]; then
	BLUE_SERVICE="${BLUE_SERVICE} bluedevil"
elif [ "$IN" == "noblue" ]; then
	BLUE_SERVICE=""
fi

read -p "Install Intel GPU Drivers? [y,n]: " IN
if [ "$IN" == "y" ]; then
	VIDEO="${INTEL}"
fi

read -p "Install AMD GPU Drivers? [y,n]: " IN
if [ "$IN" == "y" ]; then
	VIDEO="${VIDEO} ${AMD}"
fi

read -p "Install NVDIA GPU Drivers? [y,n]: " IN
if [ "$IN" == "y" ]; then
	VIDEO="${VIDEO} ${NVIDIA}"
fi

read -p "Choose your DE [xfce,plasma,mate,gnome,openbox,none]: " IN
if [ "$IN" == "xfce" ]; then
	DE="${XFCE}"
elif [ "$IN" == "plasma" ]; then
	DE="${PLASMA}"
elif [ "$IN" == "openbox" ]; then
	DE="${OPENBOX}"
elif [ "$IN" == "mate" ]; then
	DE="${MATE}"
elif [ "$IN" == "gnome" ]; then
	DE="${GNOME}"
fi

read -p "Choose your DM [lightdm,sddm,gdm,xinit,none]: " IN
if [ "$IN" == "lightdm" ]; then
	DM="${LIGHTDM}"
elif [ "$IN" == "sddm" ]; then
	DM="${SDDM}"
elif [ "$IN" == "xinit" ]; then
	DM="xinit"
elif [ "$IN" == "gdm" ]; then
	DM="gdm"
fi

read -p "Install Virtualization Tools? [y,n]: " IN
if [ "$IN" == "n" ]; then
	VIRT=""
fi

echo "Some desktop applications:"
read -p "Install Mozilla Firefox? [y,n]: " IN
if [ "$IN" == "y" ]; then
	PROGRAMS="${PROGRAMS} firefox"
fi

read -p "Install Chromium Web Browser? [y,n]: " IN
if [ "$IN" == "y" ]; then
	PROGRAMS="${PROGRAMS} chromium"
fi

read -p "Install Telegram Desktop? [y,n]: " IN
if [ "$IN" == "y" ]; then
	PROGRAMS="${PROGRAMS} telegram-desktop"
fi

read -p "Install VLC? [y,n]: " IN
if [ "$IN" == "y" ]; then
	PROGRAMS="${PROGRAMS} vlc"
fi

read -p "Install MPV? [y,n]: " IN
if [ "$IN" == "y" ]; then
	PROGRAMS="${PROGRAMS} mpv"
fi

read -p "Install OBS Studio? [y,n]: " IN
if [ "$IN" == "y" ]; then
	PROGRAMS="${PROGRAMS} obs-studio"
fi

read -p "Install Discord? [y,n]: " IN
if [ "$IN" == "y" ]; then
	PROGRAMS="${PROGRAMS} discord"
fi

read -p "Install Blender? [y,n]: " IN
if [ "$IN" == "y" ]; then
	PROGRAMS="${PROGRAMS} blender"
fi

read -p "Install Transmissioon QT or GTK [qt,gtk,none]: " IN
if [ "$IN" == "qt" ]; then
	PROGRAMS="${PROGRAMS} transmission-qt"
elif [ "$IN" == "gtk" ]; then
	PROGRAMS="${PROGRAMS} transmission-gtk"
fi

read -p "Install Steam? [y,n]: " IN
if [ "$IN" == "y" ]; then
	PROGRAMS="${PROGRAMS} steam"
fi

sudo pacman -S $CONSOLE_TOOLS $COMPRESSION_TOOLS $SERVICES $BLUE_SERVICE $SOUND_SYSTEM $XORG $FONTS $VIDEO $VULKAN_SUPPORT $DEV $DE $DM $PROGRAMS $JAVA $VIRT

read -p "Install YAY Package Manager? [y.n]: " IN
if [ "$IN" == "y" ]; then
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	rm -rf yay
fi

sudo systemctl enable sshd.service

read -p "Set xkbmap to BR ABNT2? [y,n]: " IN
if [ "$IN" == "y" ]; then
	sudo localectl set-x11-keymap br abnt2
fi

read -p "Configure touchpad tap-to-click in X11? (recomend only for WM users) [y,n]: " IN
if [ "$IN" == "y" ]; then
	sudo cp ../etc/X11/xorg.conf.d/30-touchpad.conf /etc/X11/xorg.conf.d/
fi

echo "Remeber to systemd enable your DM and Bluetooth"
echo "If using gdm remeber to /etc/gdm/custom"
