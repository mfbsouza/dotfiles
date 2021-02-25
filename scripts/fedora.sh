#!/bin/bash

# Pre requisitos:
# fastestmirror=1 e max_parallel_downloads=10 em dnf.conf
# Update automaticos desativados no Software
# RPM FUSION ativado
# Sistema atualizado
# mesa-git já instalado (caso usando)
# Git configurado
# Gnome tweaks

# Programas

PROG="steam blender obs-studio telegram-desktop discord mpv lutris transmission-gtk mangohud audacity"

# Ferramentas

TOOLS="vulkan-tools lm_sensors kernel-tools neofetch lshw procinfo android-tools"

# Programming

TOOLS="${TOOLS} clang llvm make kernel-devel SDL2-devel SDL2_image-devel glfw-devel glew-devel glm-devel"
TOOLS="${TOOLS} qemu-system-arm arm-none-eabi-gcc-cs avr-gcc avr-libc avrdude meson vulkan-headers"

# Fontes

FONTS="mozilla-fira-mono-fonts"

# Depedencias do wine

WINE="alsa-plugins-pulseaudio.i686 glibc-devel.i686 glibc-devel libgcc.i686 libX11-devel.i686 freetype-devel.i686 libXcursor-devel.i686 libXi-devel.i686 libXext-devel.i686 libXxf86vm-devel.i686 libXrandr-devel.i686 libXinerama-devel.i686 mesa-libGLU-devel.i686 mesa-libOSMesa-devel.i686 libXrender-devel.i686 libpcap-devel.i686 ncurses-devel.i686 libzip-devel.i686 lcms2-devel.i686 zlib-devel.i686 libv4l-devel.i686 libgphoto2-devel.i686 cups-devel.i686 libxml2-devel.i686 openldap-devel.i686 libxslt-devel.i686 gnutls-devel.i686 libpng-devel.i686 flac-libs.i686 json-c.i686 libICE.i686 libSM.i686 libXtst.i686 libasyncns.i686 liberation-narrow-fonts.noarch libieee1284.i686 libogg.i686 libsndfile.i686 libuuid.i686 libva.i686 libvorbis.i686 libwayland-client.i686 libwayland-server.i686 llvm-libs.i686 mesa-dri-drivers.i686 mesa-filesystem.i686 mesa-libEGL.i686 mesa-libgbm.i686 nss-mdns.i686 ocl-icd.i686 pulseaudio-libs.i686 sane-backends-libs.i686 tcp_wrappers-libs.i686 unixODBC.i686 samba-common-tools.x86_64 samba-libs.x86_64 samba-winbind.x86_64 samba-winbind-clients.x86_64 samba-winbind-modules.x86_64 mesa-libGL-devel.i686 fontconfig-devel.i686 libXcomposite-devel.i686 libtiff-devel.i686 openal-soft-devel.i686 mesa-libOpenCL-devel.i686 opencl-utils-devel.i686 alsa-lib-devel.i686 gsm-devel.i686 libjpeg-turbo-devel.i686 pulseaudio-libs-devel.i686 pulseaudio-libs-devel gtk3-devel.i686 libattr-devel.i686 libva-devel.i686 libexif-devel.i686 libexif.i686 glib2-devel.i686 mpg123-devel.i686 mpg123-devel.x86_64 libcom_err-devel.i686 libcom_err-devel.x86_64 libFAudio-devel.i686 libFAudio-devel.x86_64"


read -p "Instalar corectrl [y/n]: " IN
if [ "$IN" == "y" ]; then
	PROG="${PROG} corectrl"
fi

read -p "Instalar libva-intel-driver [y/n]: " IN
if [ "$IN" == "y" ]; then
	TOOLS="${TOOLS} libva-intel-driver intel-gpu-tools"
fi

# Instalando

sudo dnf install $PROG $TOOLS $WINE $FONTS

# Ligando serviços

#sudo systemctl enable sshd

# Lembretes

echo "ativar SSHD"
echo "ativar e ligar cpupower.service"
echo "como root cpupower frequency-set -g performance"
echo "sudo usermod -a -G dialout $USER"
echo "sudo dnf install @virtualization"
echo "disable nvidia-fallback"
echo ""
echo "sudo dnf install C development Tools and Libraries "
echo "sudo dnf install Development Tools"
echo "sudo dnf install wine"
echo ""
echo "atualizar os programas default"
