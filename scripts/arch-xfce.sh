sudo pacman -S bash-completion dmidecode vim neofetch wget picocom htop zip\
       unzip unrar net-tools openssh xdg-user-dirs bluez bluez-libs bluez-utils\
       gvfs alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pulseaudio-bluetooth\
       libcanberra libcanberra-pulse xorg xorg-xinit ttf-bitstream-vera ttf-dejavu\
       ttf-liberation noto-fonts ttf-hack ttf-ubuntu-font-family adobe-source-sans-pro-fonts\
       cantarell-fonts ttf-droid ttf-inconsolata ttf-roboto ttf-roboto-mono ttf-opensans\
       mesa lib32-mesa mesa-demos vulkan-intel libva-intel-driver libva-utils\
       intel-gpu-tools nvidia nvidia-utils lib32-nvidia-utils nvidia-settings\
       vulkan-icd-loader lib32-vulkan-icd-loader vulkan-headers vulkan-validation-layers\
       vulkan-tools clang go cmake llvm openmp python-pip linux-headers sdl2 sdl2_gfx\
       sdl2_image sdl2_mixer sdl2_net sdl2_ttf xfce4 mousepad ristretto file-roller\
       thunar-archive-plugin thunar-media-tags-plugin xfce4-battery-plugin\
       xfce4-datetime-plugin xfce4-notifyd xfce4-pulseaudio-plugin pavucontrol\
       xfce4-screensaver xfce4-screenshooter xfce4-sensors-plugin xfce4-taskmanager\
       xfce4-xkb-plugin gnome-keyring network-manager-applet nm-connection-editor\
       blueman lightdm lightdm-gtk-greeter firefox telegram-desktop vlc mpv obs-studio\
       discord blender transmission-gtk jre8-openjdk jdk8-openjdk qemu libvirt virt-manager\
       ebtables dnsmasq --noconfirm

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

sudo systemctl enable sshd.service bluetooth.service
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
sudo localectl set-x11-keymap br abnt2
