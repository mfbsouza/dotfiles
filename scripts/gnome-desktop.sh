#!/bin/bash

echo "Installing GNOME Desktop..."

echo "Installing Desktop Environment..."
sudo pacman -S cheese eog epiphany evince file-roller\
       	gdm gedit gnome-backgrounds gnome-calculator\
       	gnome-color-manager gnome-control-center\
       	gnome-disk-utility gnome-keyring gnome-logs gnome-menus\
       	gnome-screenshot gnome-session gnome-settings-daemon gnome-shell\
       	gnome-system-monitor gnome-terminal gnome-todo gnome-user-share gnome-video-effects\
       	grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb\
	mousetweaks mutter nautilus networkmanager rygel sushi totem xdg-user-dirs-gtk dconf-editor gnome-tweaks\
       	gparted gst-libav gst-plugins-good gst-plugins-base gst-plugins-bad\
	gst-plugins-ugly gstreamer-vaapi gtk-engines gtk-engine-murrine --noconfirm
