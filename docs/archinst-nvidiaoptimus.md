# My Arch Linux install "guide" for a Intel/NVIDIA Optimus laptop

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

    # timedatectl set-ntp true

## Installing the base system

### Partitioning and formatting

    # lsblk           (to check block devices on the PC)
    # gdisk /dev/sdX  (o Y n <enter> <enter> +500M ef00 n <enter> <enter> <enter> <enter> w Y)
    # mkfs.fat -F32 /dev/sdX1
    # mkfs.ext4 -L "ARCHLINUX" /dev/sdX2
    # mount /dev/sdX2 /mnt
    # mkdir /mnt/boot
    # mount /dev/sdX1 /mnt/boot

### Installing

Note that i am using the ZEN kernel

    # pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware
    # genfstab -U /mnt >> /mnt/etc/fstab

## Configuring the base system

### Chroot and some basic packages (for know)

    # arch-chroot /mnt
    # pacman -Sy networkmanager terminus-font vim nano bash-completion

### Time zone

    # ln -sf /usr/share/zoneinfo/America/Recife /etc/localtime
    # hwclock --systohc

### Locale

    # nano /etc/locale.gen (uncomment en_US and pt_BR)
    # locale-gen
    # echo "LANG=en_US.UTF-8" > /etc/locale.conf

### TTY
    
    # echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
    # echo "FONT=ter-v24n" >> /etc/vconsole.conf

### Network
    
    # echo "HOSTNAME" > /etc/hostname
    
    # nano /etc/hosts
        127.0.0.1   localhost
        ::1         localhost
        127.0.1.1   HOSTNAME.localdomain    HOSTNAME
    
    # systemctl enable NetworkManager

### Secure Shell and OpenVPN
    
    # pacman -S openssh openvpn
    # systemctl enable sshd

### Multilib
    
    # nano /etc/pacman.conf (uncomment the multilib part)
    # pacman -Syy

### User
    
    # passwd

    # useradd -m -g users -G wheel,uucp -s /bin/bash USER
    # passwd USER
    
    # usermod -c 'NAME LASTNAME' USER
    
    # EDITOR=nano visudo

### Ativando ZRAM como swap e ligando OOM handling
    
    # pacman -S zram-generator
    # vim /etc/systemd/zram-generator.conf
        [zram0]
    
    # systemctl enable systemd-oomd

### swappiness

    # echo "vm.swappiness=10" > /etc/sysctl.d/99-swappiness.conf

### improve performance for SSDs

    # systemctl enable fstrim.timer

### set cpu gorvernor to performance

    # pacman -S cpupower
    # vim /etc/default/cpupower (governor='performance')
    # sysmtectl enable cpupower.service

### Kernel modules

    # pacman -S bbswitch-dkms nvidia-dkms (dkms status, dkms autoinstall)

### Boot

    # pacman -S efibootmgr intel-ucode sof-firmware

    # bootctl --path=/boot install

    # vim /boot/loader/loader.conf
        timeout 5
        default arch-zen.conf
        
    # vim /boot/loader/entries/arch-zen.conf
        title   Arch Linux (with the ZEN Kernel & Intel GPU only)
        linux   /vmlinuz-linux-zen
        initrd  /intel-ucode.img
        initrd  /initramfs-linux-zen.img
        options root=UUID="(r! blkid)" rw quiet audit=0 pci=noaer module_blacklist=nouveau,nvidia,nvidia-drm,nvidia-modeset,nvidia-uvm bbswitch.load_state=0 bbswitch.unload_state=1 
     
    # vim /boot/loader/entries/arch-zen-nvidia.conf
        title   Arch Linux (with the ZEN Kernel & NVIDIA Optimus)
        linux   /vmlinuz-linux-zen
        initrd  /intel-ucode.img
        initrd  /initramfs-linux-zen-nvidia.img
        options root=UUID="(r! blkid)" rw quiet audit=0 pci=noaer nvidia-drm.modeset=1
   
    # vim /etc/mkinitcpio.conf
        MODULES=(i915 bbswitch)
        HOOKS=... consolefont
     
    # vim /etc/mkinitcpio-nvidia.conf
        MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
        HOOKS=... consolefont

    # vim /etc/pacman.d/hooks/90-mkinitcpio-dkms-linux-zen.hook
        [Trigger]
        Operation=Install
        Operation=Upgrade
        Operation=Remove
        Type=Package
        Target=nvidia-dkms
        Target=bbswitch-dkms

        [Action]
        Description=Update dkms modules in Linux initcpio
        Depends=mkinitcpio
        When=PostTransaction
        Exec=/usr/bin/mkinitcpio -P
   
    # vim /etc/mkinitcpio.d/linux-zen.preset
        PRESETS=('default' 'fallback' 'nvidia')

        default_image="/boot/initramfs-linux-zen.img"
        
        fallback_image="/boot/initramfs-linux-zen-fallback.img"
        fallback_options="-S autodetect"
        
        nvidia_config="/etc/mkinitcpio-nvidia.conf"
        nvidia_image="/boot/initramfs-linux-zen-nvidia.img"

    # mkinitcpio -p linux-zen

### Done (poweroff or reboot)
    
    # exit
    # umount -R /mnt
    # poweroff

## Building up the system

### redo clock sync

    $ sudo timedatectl set-ntp true

### Git

    $ sudo pacman -S git
    $ git config --global user.name "USERNAME"
    $ git config --global user.email "EMAIL"
    $ git config --global core.editor "vim"

    # can run personal scripts from here on

### Console tools

    $ sudo pacman -S dmidecode wget picocom lm_sensors neofetch tree man-db

### AUR Helper
    
    $ git clone https://aur.archlinux.org/yay.git
    $ cd yay
    $ makepkg -si
	$ cd ..
	$ rm -rf yay/

### Intel Drivers

    $ sudo pacman -Syy
    $ sudo pacman -S mesa lib32-mesa intel-media-driver libvdpau-va-gl

### Intel Vulkan Drivers
    
    $ sudo pacman -S vulkan-icd-loader lib32-vulkan-icd-loader vulkan-intel lib32-vulkan-intel

### NVIDIA Drivers
    
    $ sudo pacman -S nvidia-utils lib32-nvidia-utils opencl-nvidia nvidia-settings nvidia-prime

### Vulkan and Mesa Tools
    
    $ sudo pacman -S vulkan-tools mesa-demos

### OpenCL Tools

    $ sudo pacman -S clinfo

### Hardware Video Acceleration Utils
    
    $ sudo pacman -S libva-utils

### Desktop Enviroment (Gnome)

    $ sudo pacman -S gnome dconf-editor gnome-tweaks xdg-desktop-portal xdg-desktop-portal-gtk
        (remove: ^ epiphany gnome-books gnome-characters gnome-contacts gnome-documents gnome-font-viewer gnome-maps gnome-photos gnome-shell-extensions gnome-software gnome-user-docs gnome-boxes simple-scan)

    $ sudo pacman -S power-profiles-daemon
    $ sudo systemctl enable power-profiles-daemon 
    
    $ sudo systemctl enable gdm

    $ yay -S chrome-gnome-shell --noconfirm

### Network Manager VPN front-ends

    $ sudo pacman -S networkmanager-openvpn

### Pirewire

    $ sudo pacman -S pipewire lib32-pipewire pipewire-alsa pipewire-pulse pipewire-jack gst-plugin-pipewire 

### Gstreamer Hardware Acceleration

    $ sudo pacman -S gst-libav gstreamer-vaapi

### Fonts
    
    $ sudo pacman -S ttf-bitstream-vera ttf-fira-mono ttf-fira-code ttf-fira-sans ttf-dejavu tff-liberation noto-fonts ttf-hack adobe-source-sans-pro-fonts ttf-droid ttf-inconsolata ttf-roboto ttf-roboto-mono ttf-opensans

### Deveveloper packages
    
    $ sudo pacman -S clang llvm electron openmp python-pip vulkan-headers arm-none-eabi-gcc arm-none-eabi-newlib

### JAVA basic support
    
    $ sudo pacman -S jdk8-openjdk jre8-openjdk

### Programs
    
    $ sudo pacman -S chromium firefox telegram-desktop steam mpv trasmission-gtk obs-studio gamemode lib32-gamemode kdenlive breeze breeze-gtk

    $ yay -S visual-studio-code-bin discord_arch_electron mangohud downgrade --noconfirm
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

