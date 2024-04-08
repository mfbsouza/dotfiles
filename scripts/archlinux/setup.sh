#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'


echo -e "\n$GREEN Arch Linux setup personal script by mfbsouza $CLEAR\n"

echo -e "\n$GREEN Install basic terminal packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S bash-completion git openssh rsync less fzf \
		htop tmux fd ripgrep usbutils fastfetch vim wget unzip \
		stress tree inxi net-tools dnsutils
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install GNOME desktop environment? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S gnome gnome-browser-connector firefox alacritty
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	sudo systemctl enable gdm
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install KDE Plasma desktop environment? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S plasma dolphin kcalc ffmpegthumbs \
		kdegraphics-thumbnailers kate okular kwalletmanager \
		spectacle firefox alacritty
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	sudo systemctl enable sddm
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install i3wm desktop packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S xorg xorg-xinit i3 dmenu j4-dmenu-desktop picom \
		dunst feh alacritty firefox thunar thunar-archive-plugin \
		gvfs udiskie tumbler ffmpegthumbnailer xarchiver lxrandr \
		lxappearance pavucontrol volumeicon gpicview maim xdotool \
		xdg-utils xdg-user-dirs xdg-desktop-portal-gtk blueman \
		bluez-utils gnome-keyring network-manager-applet filelight \
		nm-connection-editor xss-lock systemd-resolvconf breeze \
		breeze-gtk breeze-icons qt6ct brightnessctl
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install VPN packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S openvpn networkmanager-openvpn networkmanager-l2tp \
		networkmanager-strongswan wireguard-tools
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install software development packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S gdb go rustup bear valgrind neovim xsel xclip \
		meson cmake clang llvm python-pip jre-openjdk docker lcov \
		python-setuptools
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	rustup default stable
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install KiCad? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S kicad
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	sudo pacman -S --asdeps kicad-library kicad-library-3d
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install virtualization packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S virt-manager qemu-desktop
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install Kdenlive? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S kdenlive
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install Krita? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S krita
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install mpv and multimedia codecs? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S mpv gst-libav gst-plugins-ugly libva-utils
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install fonts? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji \
		ttf-liberation ttf-inconsolata-nerd
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install transmission-gtk package? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S transmission-gtk
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install transmission-qt package? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S transmission-qt
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install cpupower? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S cpupower
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install powertop? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S powertop
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install partitioning packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S parted gptfdisk dosfstools exfat-utils ntfs-3g
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install usb_modeswitch and modem manager? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S usb_modeswitch modemmanager
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	sudo systemctl enable ModemManager
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install flatpak? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S flatpak
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install helvum? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S helvum
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install nvidia graphics packages and nvidia settings? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S opencl-nvidia cuda nvidia-utils libva-nvidia-driver \
		nvidia-settings
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install nvidia lib32 packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S lib32-nvidia-utils
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install amd graphics packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S mesa vulkan-radeon libva-mesa-driver opencl-mesa
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install amdgpu lib32 packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S lib32-vulkan-radeon
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install intel graphics packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S mesa vulkan-intel intel-media-driver intel-compute-runtime \
		intel-gpu-tools
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install intel graphics lib32 packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S lib32-vulkan-intel
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install gaming packages? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S mangohud steam wine-staging winetricks lutris
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install intel undervolt tool? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S intel-undervolt
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install nvidia prime switch tool? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S nvidia-prime
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
fi

echo -e "\n$GREEN Install TLP for power managment? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo pacman -S tlp tlp-rdw smartmontools ethtool
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	echo -e "\n$GREEN enabling TLP service... $CLEAR\n"
	sudo systemctl enable tlp
	sudo systemctl enable NetworkManager-dispatcher.service
	sudo systemctl mask systemd-rfkill.service
	sudo systemctl mask systemd-rfkill.socket
fi

echo -e "\n$GREEN Set cpu to performance governor? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo sed -i "s/#governor='ondemand'/governor='performance'/g" \
		/etc/default/cpupower
	if [ "$?" -ne 0 ]; then
		echo -e "\n$RED Something went wrong! Stopping... $CLEAR\n"
		exit 1
	fi
	echo -e "\n$GREEN enabling cpupower service... $CLEAR\n"
	sudo systemctl enable cpupower.service
fi


echo -e "\n$GREEN Install yay for AUR package managment? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
	cd /tmp/yay-bin
	makepkg -si
	cd -
fi

echo -e "\n$GREEN Install downgrade utility? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	yay -S downgrade
fi

echo -e "\n$GREEN Install visual studio code? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	yay -S visual-studio-code-bin
fi

echo -e "\n$GREEN Install google chrome? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	yay -S google-chrome
fi

echo -e "\n$GREEN Install Postman? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	yay -S postman-bin
fi

echo -e "\n$GREEN Install Saleae Logic2? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	yay -S saleae-logic2
fi

echo -e "\n$GREEN Enable systemd services? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo systemctl enable systemd-resolved
	sudo systemctl enable bluetooth
	sudo systemctl enable sshd
	sudo systemctl enable docker
	sudo systemctl enable libvirtd
fi

echo -e "\n$GREEN Adding user to groups... $CLEAR\n"

echo -e "\n$GREEN Add user to docker group? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo usermod -a -G docker $USER
fi

echo -e "\n$GREEN Add user to uucp group? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo usermod -a -G uucp $USER
fi

echo -e "\n$GREEN Add user to wireshark group? [y/N] $CLEAR\n"
read ANS
if [ "$ANS" == "y" ]; then
	sudo usermod -a -G wireshark $USER
fi

echo -e "\n$GREEN Done! $CLEAR\n"
exit 0
