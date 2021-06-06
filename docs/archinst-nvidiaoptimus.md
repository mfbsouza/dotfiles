# My Arch Linux install "guide" for a Intel/NVIDIA Optimus laptop

## Pre-install

### Keyboard layout, test internet connection and change font

    # loadkeys br-abnt2
    # ping -c3 google.com
	# setfont ter-v24n

### Configuring pacman mirrorlist

download a pre-build mirrorlist

    # curl https://pastebin.com/raw/CYpGGTFW --output test.txt
    # mv test.txt /etc/pacman.d/mirrorlist
    # pacman -Syy

or generate a new mirrorlist

    # pacman -Sy reflector
    # cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    # reflector --verbose --latest 50 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
    # pacman -Syy

### Update system clock

    # timedatectl status
    # timedatectl set-local-rtc 1
    # timedatectl set-ntp true

## Installing the base system

### Partitioning and formatting

    # lsblk           (to check block devices on the PC)
    # gdisk /dev/sdX  (o Y n <enter> <enter> +500M ef00 n <enter> <enter> <enter> <enter> w Y)
    # mkfs.fat -F32 /dev/sdX1
    # mkfs.ext4 -L "Root" /dev/sdX2
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
    # pacman -Sy networkmanager terminus-font vim nano

### Time zone

    # ln -sf /usr/share/zoneinfo/America/Recife /etc/localtime
    # timedatectl status
    # hwclock --systohc --localtime

### Locale

    # nano /etc/locale.gen
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

### Secure Shell
    
    # pacman -S openssh
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

### Ativando ZRAM
    
    # echo 'zram' | tee /etc/modules-load.d/zram.conf
    # echo 'options zram num_devices=1' | tee /etc/modprobe.d/zram.conf
    # echo -e 'KERNEL=="zram0", ATTR{disksize}="4G" RUN="/usr/bin/mkswap /dev/zram0", TAG+="systemd"' | tee /etc/udev/rules.d/99-zram.rules
    # echo -e '/dev/zram0 none swap defaults 0 0' | tee -a /etc/fstab

### Kernel modules

    # pacman -S bbswitch-dkms nvidia-dkms (dkms status, dkms autoinstall)

### Boot

    # pacman -S efibootmgr intel-ucode ntfs-3g

    # bootctl --path=/boot install

    # vim /boot/loader/loader.conf
        timeout 5
        default arch-zen.conf
        
    # vim /boot/loader/entries/arch-zen.conf
        title   Arch Linux (with the ZEN Kernel & Intel GPU only)
        linux   /vmlinuz-linux-zen
        initrd  /intel-ucode.img
        initrd  /initramfs-linux-zen.img
        options root=UUID="(r! blkid)" rw quiet module_blacklist=nouveau,nvidia,nvidia-drm,nvidia-modeset,nvidia-uvm bbswitch.load_state=0 bbswitch.unload_state=1 
     
    # vim /boot/loader/entries/arch-zen-nvidia.conf
        title   Arch Linux (with the ZEN Kernel & NVIDIA Optimus)
        linux   /vmlinuz-linux-zen
        initrd  /intel-ucode.img
        initrd  /initramfs-linux-zen-nvidia.img
        options root=UUID="(r! blkid)" rw quiet nvidia-drm.modeset=1
   
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
        Target=linux-zen

        [Action]
        Description=Update dkms modules in Linux initcpio
        Depends=mkinitcpio
        When=PostTransaction
        NeedsTargets
        Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -p linux-zen'
   
    # vim /etc/mkinitcpio.d/linux-zen.preset
        PRESETS=('default' 'default-nvidia' 'fallback')

        #default-nvidia_config="/etc/mkinitcpio-nvidia.conf"
        #default-nvidia_image="/boot/initramfs-linux-zen-nvidia.img"
        #default-nvidia_options=""

    # mkinitcpio -p linux-zen

### Done (poweroff or reboot)
    
    # exit
    # umount -R /mnt
    # poweroff

## Building up the system

### Console tools

    $ sudo pacman -S bash-completion dmidecode wget picocom net-tools zip unzip unrar lm_sensors neofetch lshw procinfo-ng android-tools man-db

### Git

    $ sudo pacman -S git
    $ git config --global user.name "USERNAME"
    $ git config --global user.email "EMAIL"

### AUR Helper
    
    $ git clone https://aur.archlinux.org/yay.git
    $ cd yay
    $ makepkg -si
	$ cd ..
	$ rm -rf yay/

### Intel Drivers

    $ sudo pacman -Syy
    $ sudo pacman -S mesa lib32-mesa libva-intel-driver lib32-libva-intel-driver

### NVIDIA Drivers
    
    $ sudo pacman -S nvidia-utils lib32-nvidia-utils nvidia-settings nvidia-prime

### Intel Vulkan Drivers
    
    $ sudo pacman -S vulkan-icd-loader lib32-vulkan-icd-loader vulkan-intel lib32-vulkan-intel

### Vulkan and Mesa Tools
    
    $ sudo pacman -S vulkan-tools mesa-demos

### AMD OpenCL Propietary Driver
    
    $ yay -S opencl-amd --noconfirm 

### OpenCL Tools

    $ sudo pacman -S clinfo

### Hardware Video Acceleration Utils
    
    $ sudo pacman -S libva-utils

### Desktop Enviroment
    
    $ sudo pacman -S gnome (^3 ^33 ^34) dconf-editor gnome-tweaks gtk-engine-murrine chrome-gnome-shell
    $ sudo vim /etc/gdm/custom.conf (disable wayland)
    $ sudo systemctl enable gdm

### Pirewire

    $ sudo pacman -S pipewire lib32-pipewire pipewire-docs pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire-jack

    $ sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk

### Fonts
    
    $ sudo pacman -S ttf-bitstream-vera ttf-fira-mono ttf-fira-code ttf-fira-sans ttf-dejavu tff-liberation noto-fonts ttf-hack adobe-source-sans-pro-fonts ttf-droid ttf-inconsolata ttf-roboto ttf-roboto-mono ttf-opensans

### Deveveloper packages
    
    $ sudo pacman -S openmp python-pip vulkan-headers sdl2_image arm-none-eabi-gcc

### JAVA basic support
    
    $ sudo pacman -S jdk8-openjdk jre8-openjdk

### Programs
    
    $ sudo pacman -S firefox chromium telegram-desktop steam mpv trasmission-gtk obs-studio discord krita gamemode lib32-gamemode kdenlive breeze breeze-gtk

    $ yay -S visual-studio-code-bin --noconfirm
    $ yay -S manoghud corectrl --noconfirm

### Restart the computer

    configure the setings (microphone volume, region language, time, terminal color, tweaks, dconf)
    Restart again

### Wine
    
    sudo pacman -S wine-staging winetricks giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs cups samba dosbox lutris