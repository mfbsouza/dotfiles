#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# nvidia vaapi config
export LIBVA_DRIVER_NAME='nvidia'
export NVD_BACKEND='direct'
export MOZ_DISABLE_RDD_SANDBOX='1'

# xdg config and qt apps theming
export XDG_CURRENT_DESKTOP='i3'
export QT_QPA_PLATFORMTHEME='qt6ct'

# keyboard config
setxkbmap -layout us -variant alt-intl &

# default monitor config
xrandr --output DP-0 --mode 1920x1080 --rate 119.98 --primary &

exec i3
