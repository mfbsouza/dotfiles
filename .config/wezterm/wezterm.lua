local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 10.0

-- disable ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- customize default color scheme
local custom_theme = wezterm.color.get_builtin_schemes()['midnight-in-mojave'];
custom_theme.ansi[1] = '#333333'
custom_theme.brights[1] = '#3d3d3d'

config.color_schemes = {
  ['Midnight in Mojave'] = custom_theme,
}
config.color_scheme = 'Midnight in Mojave';

config.audible_bell = "Disabled"

-- keybinds
config.keys = {
  -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
  -- Make Option-Right equivalent to Alt-f; forward-word
  {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
}

return config

