#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# User specific environment and startup programs
export MOZ_ENABLE_WAYLAND=1
export MOZ_WEBRENDER=1
export QT_QPA_PLATFORM=wayland
export MESA_DISK_CACHE_SINGLE_FILE=1
