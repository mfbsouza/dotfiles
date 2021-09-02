#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# User specific environment and startup programs

# Firefox wayland flags
export MOZ_ENABLE_WAYLAND=1
export MOZ_WEBRENDER=1
export MOZ_DISABLE_RDD_SANDBOX=1

# Qt wayland flags
export QT_QPA_PLATFORM=wayland

# SDL wayland flags
export SDL_VIDEODRIVER=wayland

# Clutter wayland flags
export CLUTTER_BACKEND=wayland

# Mesa Flags
export MESA_DISK_CACHE_SINGLE_FILE=1
