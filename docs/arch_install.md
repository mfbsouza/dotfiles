# My Arch Linux install step by step

**WARING**: this step by step was ment for my use, there may be steps witch are not very clear what it should do (like open the editor in some file and not saying what to change on it),that is because i am used to it. If you wish to follow this, please be aware of the objectives in each step.

## Pre-install

### Keyboard layout, test internet connection and change font

    # loadkeys br-abnt2
    # ping -c3 google.com
    # setfont ter-v24n

### Configuring pacman mirrorlist

download a pre-built mirrorlist for Brazil servers

    # curl https://pastebin.com/raw/kxfEeJNC -o mirrors.txt
    # cat mirrors.txt > /etc/pacman.d/mirrorlist
    # pacman -Syy

or generate a new mirrorlist

    # pacman -Sy reflector
    # cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    # reflector --verbose --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
    # pacman -Syy

### Update system clock

    # timedatectl set-ntp true

## Installing the base system

### Partitioning and formatting

    # lsblk
    # gdisk /dev/nvme0n1

    # mkfs.fat -F32 /dev/nvme0n1p1
    # mkfs.ext4 -L "rootfs" /dev/nvme0n1p3
    # mkswap /dev/nvme0n1p2
    # swapon /dev/nvme0n1p2

    # mount /dev/nvme0n1p3 /mnt
    # mkdir /mnt/boot
    # mount /dev/nvme0n1p1 /mnt/boot

### Installing

    # pacstrap /mnt base base-devel linux linux-firmware linux-headers
    # genfstab -U /mnt >> /mnt/etc/fstab

## Configuring the base system

### Chroot and some basic packages for a minimal system

    # arch-chroot /mnt

networking

    # pacman -Sy networkmanager

utilities

    # pacman -S gvim git tree wget screen man-db dmidecode neofetch bash-completion lm_sensors

fonts

    # pacman -S ttf-liberation ttf-dejavu $(pacman -Ssq noto-fonts)

### Timezone

    # ln -sf /usr/share/zoneinfo/America/Recife /etc/localtime
    # hwclock --systohc

### Locale

    # vim /etc/locale.gen
    # locale-gen
    # echo "LANG=en_US.UTF-8" > /etc/locale.conf

### TTY
    
    # echo "KEYMAP=br-abnt2" > /etc/vconsole.conf

### Network
    
    # echo "HOSTNAME" > /etc/hostname
    
    # vim /etc/hosts
        127.0.0.1   localhost
        ::1         localhost
        127.0.1.1   HOSTNAME.localdomain    HOSTNAME
    
    # systemctl enable NetworkManager

### Secure Shell and OpenVPN
    
    # pacman -S openssh openvpn
    # systemctl enable sshd

### Multilib
    
    # vim /etc/pacman.conf (uncomment the multilib part)
    # pacman -Syy

### User
    
    # passwd

    # useradd -m -g users -G wheel,uucp -s /bin/bash USER
    # passwd USER
    
    # usermod -c 'NAME LASTNAME' USER
    
    # EDITOR=vim visudo

### Enable ZRAM as swap and turing on OOM handling (if not using disk swap)
    
    # pacman -S zram-generator
    # vim /etc/systemd/zram-generator.conf
        [zram0]
    
    # systemctl enable systemd-oomd

### Swappiness

    # echo "vm.swappiness=10" > /etc/sysctl.d/99-swappiness.conf

### improve performance for SSDs

    # systemctl enable fstrim.timer

### Boot

- [Boot for Intel or AMD CPU + AMDGPU](#boot-amdgpu)
- [Boot for laptops with Intel CPU/GPU + Nvidia](#boot-intel-laptops-with-nvidia-optimus)
- [Boot for Intel or AMD CPU + NVIDIA](#boot-nvidiagpu)

### Boot AMDGPU

    # pacman -S efibootmgr sof-firmware (amd-ucode or intel-ucode)
    
    # bootctl --path=/boot install
    
    # vim /boot/loader/loader.conf
        default arch-zen.conf
        
    # vim /boot/loader/entries/arch-zen.conf
        title   Arch Linux (with the ZEN Kernel)
        linux   /vmlinuz-linux-zen
        initrd  /(amd-ucode or intel-ucode).img
        initrd  /initramfs-linux-zen.img
        options root=UUID="(r! blkid)" rw quiet audit=0 amdgpu.ppfeaturemask=0xffffffff

    # vim /etc/mkinitcpio.conf
        MODULES=(... amdgpu ...)
        HOOKS=... consolefont
        
    # mkinitcpio -p linux-zen

### Boot intel laptops with Nvidia Optimus

	# pacman -S efibootmgr intel-ucode sof-firmware bbswitch-dkms nvidia-dkms (dkms status, dkms autoinstall)

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

### Boot NVIDIAGPU

    # pacman -S efibootmgr (amd-ucode or intel-ucode) nvidia-dkms (dkms status, dkms install)
    
    # bootctl --path=/boot install
    
    # vim /boot/loader/loader.conf
        default arch-zen.conf
        
    # vim /boot/loader/entries/arch-zen.conf
        title   Arch Linux (with the ZEN Kernel)
        linux   /vmlinuz-linux-zen
        initrd  /(amd-ucode or intel-ucode).img
        initrd  /initramfs-linux-zen.img
        options root=UUID="(r! blkid)" rw quiet audit=0 nvidia-drm.modeset=1

    # vim /etc/mkinitcpio.conf
        MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
        HOOKS=... consolefont
        
    # mkinitcpio -p linux-zen



### Done (poweroff or reboot)
    
    # exit
    # umount -R /mnt
    # poweroff

## Building up the system

### redo clock sync

    $ sudo timedatectl set-ntp true
    $ sudo hwclock --systohc

### Git

    $ git config --global user.name "USERNAME"
    $ git config --global user.email "EMAIL"
    $ git config --global core.editor "vim"

### Building the system up

#### AUR

    $ git clone https://aur.archlinux.org/yay.git
    $ cd yay
    $ makepkg -si
    $ cd ..
    $ rm -rf yay/

#### DE

    $ sudo pacman -S xorg gnome pipewire-pulse gnome-themes-extra ffmpegthumbnailer gst-libav
    $ sudo pacman -S gnome-shell-extension-appindicator
    $ sudo pacman -S networkmanager-openvpn usbutils
    $ sudo systemctl enable gdm
    $ sudo vim /etc/gdm/custom.conf

#### Graphics Stack

AMD

    $ sudo pacman -S vulkan-icd-loader
    $ sudo pacman -S mesa vulkan-radeon libva-mesa-driver
    $ sudo pacman -S mesa-utils mesa-demos vulkan-tools libva-utils

INTEL

    $ sudo pacman -S vulkan-icd-loader
    $ sudo pacman -S mesa vulkan-intel intel-media-driver
    $ sudo pacman -S mesa-utils mesa-demos vulkan-tools libva-utils

#### Desktop Apps

    $ sudo pacman -S firefox vlc transmission-gtk

#### Qemu stuff

    $ sudo pacman -S qemu-desktop