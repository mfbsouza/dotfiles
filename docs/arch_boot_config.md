# Boot configuration examples for systemd-boot in Arch Linux

**WARING**: this step by step was ment for my use, there may be steps witch
are not very clear what it should do (like open the editor in some file and
not saying what to change on it),that is because i am used to it. If you wish
to follow this, please be aware of the objectives in each step.

## Boot

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
