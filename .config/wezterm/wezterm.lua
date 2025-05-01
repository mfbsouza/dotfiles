local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 11.0

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

return config

