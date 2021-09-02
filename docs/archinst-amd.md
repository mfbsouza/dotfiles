# My Arch Linux install "guide" for a AMD CPU/GPU PC

## Pre-install

### Keyboard layout, test internet connection and change font

    # loadkeys br-abnt2
    # ping -c3 google.com
	# setfont ter-v24n

### Configuring pacman mirrorlist

download a pre-build mirrorlist

    # curl https://pastebin.com/raw/CYpGGTFW --output test.txt
    # cat test.txt > /etc/pacman.d/mirrorlist
    # pacman -Syy

or generate a new mirrorlist

    # pacman -Sy reflector
    # cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    # reflector --verbose --latest 50 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
    # pacman -Syy

### Update system clock

    # timedatectl status
    # timedatectl set-local-rtc 1
    # timedatectl set-ntp 1

## Installing the base system

### Partitioning and formatting

    # lsblk               (to check block devices on the PC)
    # gdisk /dev/nvme0n1  (o Y n <enter> <enter> +500M ef00 n <enter> <enter> <enter> <enter> w Y)
    # mkfs.fat -F32 /dev/nvme0n1p1
    # mkfs.ext4 -L "ARCHLINUX" /dev/nvme0n1p2
    # mount /dev/nvme0n1p2 /mnt
    # mkdir /mnt/boot
    # mount /dev/nvme0n1p1 /mnt/boot

### Installing

Note that i am using the ZEN kernel

    # pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware
    # genfstab -U /mnt >> /mnt/etc/fstab

## Configuring the base system

### Chroot and some basic packages (for know)

    # arch-chroot /mnt
    # pacman -Sy networkmanager modemmanager usb_modeswitch terminus-font vim nano

### Time zone

    # ln -sf /usr/share/zoneinfo/America/Recife /etc/localtime
    # timedatectl set-local-rtc 1
    # timedatectl set-ntp 1
    # timedatectl status
    # hwclock --systohc --localtime

### Locale

    # nano /etc/locale.gen (uncomment en_US and pt_BR)
    # locale-gen
    # echo "LANG=en_US.UTF-8" > /etc/locale.conf

### Console
    
    # echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
    # echo "FONT=ter-v24n" >> /etc/vconsole.conf

### Network
    
    # echo "HOSTNAME" > /etc/hostname
    
    # nano /etc/hosts
        127.0.0.1   localhost
        ::1         localhost
        127.0.1.1   HOSTNAME.localdomain    HOSTNAME
    
    # systemctl enable NetworkManager
    # systemctl enable ModemManager

### Secure Shell and OpenVPN
    
    # pacman -S openssh openvpn
    # systemctl enable sshd

### Multilib
    
    # nano /etc/pacman.conf (uncomment the multilib part)
    # pacman -Syy

### User
    
    # passwd
    # useradd -m -g users -G wheel,storage,power,rfkill,uucp -s /bin/bash USER
    # passwd USER
    # usermod -c 'NAME LASTNAME' USER
    # EDITOR=nano visudo

### Ativando ZRAM como swap
    
    # vim /etc/modules-load.d/zram.conf
        zram
    # vim /etc/modprobe.d/zram.conf
        options zram num_devicees=1
    # vim /etc/udev/rules.d/99-zram.rules
        KERNEL=="zram0", ATTR{disksize}="4G" RUN="/usr/bin/mkswap /dev/zram0", TAG+="systemd"
    # vim /etc/fstab
        /dev/zram0 none swap defaults 0 0

### Swappiness

    # echo "vm.swappiness=10" > /etc/sysctl.d/99-swappiness.conf

### CPUPOWER

    # pacman -S cpupower
    # vim /etc/default/cpupower (governor='performance')
    # sysmtectl enable cpupower.service

### Boot
    
    # pacman -S efibootmgr amd-ucode ntfs-3g
    # bootctl --path=/boot install
    
    # vim /boot/loader/loader.conf
        default arch-zen.conf
        
    # vim /boot/loader/entries/arch-zen.conf
        title   Arch Linux (with the ZEN Kernel)
        linux   /vmlinuz-linux-zen
        initrd  /amd-ucode.img
        initrd  /initramfs-linux-zen.img
        options root=UUID="(r! blkid)" rw quiet audit=0 amdgpu.ppfeaturemask=0xffffffff

    # vim /etc/mkinitcpio.conf
        MODULES=(... amdgpu ...)
        HOOKS=... consolefont
        
    # mkinitcpio -p linux-zen

### Done (poweroff or reboot)
    
    # exit
    # umount -R /mnt
    # poweroff

## Building up the system

### Console tools

    $ sudo pacman -S bash-completion dmidecode wget picocom net-tools zip unzip unrar lm_sensors neofetch procinfo-ng android-tools tree man-db

### Git

    $ sudo pacman -S git
    $ git config --global user.name "USERNAME"
    $ git config --global user.email "EMAIL"
    $ git config --global core.editor "vim"

### AUR Helper
    
    $ git clone https://aur.archlinux.org/yay.git
    $ cd yay
    $ makepkg -si
	$ cd ..
	$ rm -rf yay/

### AMDGPU Drivers
    
    $ sudo pacman -Syy
    $ sudo pacman -S mesa lib32-mesa libva-mesa-driver lib32-libva-mesa-driver

### AMD Vulkan Drivers
    
    $ sudo pacman -S vulkan-icd-loader lib32-vulkan-icd-loader vulkan-radeon lib32-vulkan-radeon

### Vulkan and Mesa Tools
    
    $ sudo pacman -S vulkan-tools mesa-demos

### AMD OpenCL Propietary Driver
    
    $ yay -S opencl-amd --noconfirm 

### OpenCL Tools

    $ sudo pacman -S clinfo

### Hardware Video Acceleration Utils
    
    $ sudo pacman -S libva-utils

### Desktop Enviroment (Gnome)

    $ sudo pacman -S gnome dconf-editor gnome-tweaks
        (remove: ^ epiphany gnome-contacts gnome-documents gnome-maps gnome-shell-extensions gnome-software gnome-user-docs gnome-boxes simple-scan) 
    
    $ sudo systemctl enable gdm
    $ yay -S chrome-gnome-shell --noconfirm

### Network Manager VPN front-ends

    $ sudo pacman -S networkmanager-openvpn networkmanager-l2tp strongswan

### Pirewire

    $ sudo pacman -S pipewire lib32-pipewire pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire-jack

    $ sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk gst-plugin-pipewire 

### Gstreamer Hardware Acceleration

    $ sudo pacman -S gstreamer-vaapi

### Fonts
    
    $ sudo pacman -S ttf-bitstream-vera ttf-fira-mono ttf-fira-code ttf-fira-sans ttf-dejavu tff-liberation noto-fonts ttf-hack adobe-source-sans-pro-fonts ttf-droid ttf-inconsolata ttf-roboto ttf-roboto-mono ttf-opensans

### Deveveloper packages
    
    $ sudo pacman -S clang llvm electron openmp python-pip vulkan-headers sdl2_image arm-none-eabi-gcc arm-none-eabi-newlib

### JAVA basic support
    
    $ sudo pacman -S jdk8-openjdk jre8-openjdk

### Programs
    
    $ sudo pacman -S firefox chromium steam mpv trasmission-(gtk/qt) obs-studio krita gamemode lib32-gamemode kdenlive breeze breeze-gtk

    $ yay -S visual-studio-code-bin telegram-desktop-bin discord_arch_electron mangohud downgrade --noconfirm
    $ yay -S corectrl --noconfirm
    $ yay -S protontricks --noconfirm

### Virtualization

    $ sudo pacman -S libvirt virt-manager qemu qemu-arch-extra edk2-ovmf

Networking packages

    $ sudo pacman -S iptables-nft dnsmasq

Enable services

    $ sudo systemctl enable libvirtd.service

### Restart the computer

    configure the setings (microphone volume, region language, time, terminal color, tweaks, dconf)
    Restart again

### Firefox VAAPI flags

    media.ffmpeg.vaapi.enabled to true
    media.ffvpx.enabled to false
    media.rdd-vpx.enabled to false
    media.navigator.mediadatadecoder_vpx_enabled to true
    If you experience page crashes, try setting security.sandbox.content.level to 0

### Wine
   
    sudo pacman -S wine-staging winetricks lib32-giflib lib32-libpng lib32-gnutls lib32-mpg123 lib32-openal lib32-v4l-utils lib32-libpulse lib32-libjpeg-turbo lib32-libxcomposite lib32-libxinerama lib32-opencl-icd-loader lib32-libxslt lib32-libva lib32-gtk3 lib32-gst-plugins-base-libs cups samba dosbox lutris
 
