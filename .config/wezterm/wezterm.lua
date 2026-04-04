local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local is_linux <const> = wezterm.target_triple:find('linux') ~= nil


-- ============================================
-- Appearance
-- ============================================

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0

local custom_theme = wezterm.color.get_builtin_schemes()['midnight-in-mojave'];
custom_theme.ansi[1] = '#333333'
custom_theme.brights[1] = '#3d3d3d'
if is_linux then
  custom_theme.background = '#222226'
end

config.color_schemes = {
  ['Midnight in Mojave'] = custom_theme,
}
config.color_scheme = 'Midnight in Mojave';

wezterm.on('update-status', function(window, pane)
  local workspace = window:active_workspace()
  local date = wezterm.strftime('%Y/%m/%d %H:%M:%S')

  window:set_left_status(wezterm.format {
    { Foreground = { Color = '#073642' } },
    { Background = { Color = '#2aa198' } },
    { Text = '  ' .. workspace .. ' ' },
  })

  window:set_right_status(wezterm.format {
    { Foreground = { Color = '#c6c6c6' } },
    { Text = ' ' .. date .. ' ' },
  })
end)

config.colors = {
  tab_bar = {
    background = 'none',
    active_tab = {
      bg_color = 'none',
      fg_color = '#2aa198',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = 'none',
      fg_color = '#c6c6c6',
    },
    inactive_tab_hover = {
      bg_color = '#333333',
      fg_color = '#c6c6c6',
    },
    new_tab = {
      bg_color = 'none',
      fg_color = '#888888',
    },
  }
}

config.switch_to_last_active_tab_when_closing_tab = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 32

config.audible_bell = 'Disabled'

-- ============================================
-- Tmux-like settings
-- ============================================

config.use_dead_keys = false
config.leader = {key='a', mods = 'CTRL', timeout_milliseconds = 2000}
config.keys = {
  {key='[', mods='LEADER', action=wezterm.action.ActivateCopyMode},
  {key='z', mods='LEADER', action=wezterm.action.TogglePaneZoomState},
  {key='c', mods='LEADER', action=wezterm.action.SpawnTab 'CurrentPaneDomain'},
  {key='n', mods='LEADER', action=wezterm.action.ActivateTabRelative(1)},
  {key='p', mods='LEADER', action=wezterm.action.ActivateTabRelative(-1)},
  {key='a', mods='LEADER', action=wezterm.action.AttachDomain 'unix'},
  {key='d', mods='LEADER', action=wezterm.action.DetachDomain{DomainName='unix'}},
  {key='w', mods='LEADER', action=wezterm.action.ShowTabNavigator},
  {key='s', mods='LEADER', action=wezterm.action.ShowLauncherArgs {flags = 'WORKSPACES'}},
  {key='"', mods='LEADER', action=wezterm.action.SplitPane{direction='Down', size={Percent=50}}},
  {key='x', mods='LEADER', action=wezterm.action.CloseCurrentPane{confirm=false}},
  {key='&', mods='LEADER|SHIFT', action=wezterm.action.CloseCurrentTab{confirm=false}},
  {key='%', mods='LEADER|SHIFT', action=wezterm.action.SplitPane{direction='Right', size={Percent=50}}},
  {key='{', mods='LEADER|SHIFT', action=wezterm.action.RotatePanes 'CounterClockwise' },
  {key='}', mods='LEADER|SHIFT', action=wezterm.action.RotatePanes 'Clockwise' },
  {key='UpArrow', mods='LEADER', action=wezterm.action.ActivatePaneDirection 'Up'},
  {key='DownArrow', mods='LEADER', action=wezterm.action.ActivatePaneDirection 'Down'},
  {key='LeftArrow', mods='LEADER', action=wezterm.action.ActivatePaneDirection 'Left'},
  {key='RightArrow', mods='LEADER', action=wezterm.action.ActivatePaneDirection 'Right'},
  {key=',', mods='LEADER',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      ),
    },
  },
  {key='$', mods='LEADER|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for session',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            mux.rename_workspace(
              window:mux_window():get_workspace(),
              line
            )
          end
        end
      ),
    },
  },
  {key='1', mods='LEADER', action=wezterm.action.ActivateTab(0)},
  {key='2', mods='LEADER', action=wezterm.action.ActivateTab(1)},
  {key='3', mods='LEADER', action=wezterm.action.ActivateTab(2)},
  {key='4', mods='LEADER', action=wezterm.action.ActivateTab(3)},
  {key='5', mods='LEADER', action=wezterm.action.ActivateTab(4)},
  {key='6', mods='LEADER', action=wezterm.action.ActivateTab(5)},
  {key='7', mods='LEADER', action=wezterm.action.ActivateTab(6)},
  {key='8', mods='LEADER', action=wezterm.action.ActivateTab(7)},
  {key='9', mods='LEADER', action=wezterm.action.ActivateTab(8)},
  -- Support for option-left/right in macOS
  {key='LeftArrow', mods='OPT', action=wezterm.action{SendString='\x1bb'}},
  {key='RightArrow', mods='OPT', action=wezterm.action{SendString='\x1bf'}},
}

return config

