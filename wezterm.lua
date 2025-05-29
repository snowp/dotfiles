local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font('Hack Nerd Font', { weight = 'Regular' })
config.font_size = 13.0

config.enable_tab_bar = false

config.window_decorations = 'RESIZE'

-- Kanso Zen colorscheme
config.force_reverse_video_cursor = true
config.colors = {
  foreground = "#C5C9C7",
  background = "#090E13",

  cursor_bg = "#090E13",
  cursor_fg = "#C5C9C7",
  cursor_border = "#C5C9C7",

  selection_fg = "#C5C9C7",
  selection_bg = "#24262D",

  scrollbar_thumb = "#24262D",
  split = "#24262D",

  ansi = {
    "#090E13",
    "#C4746E",
    "#8A9A7B",
    "#C4B28A",
    "#8BA4B0",
    "#A292A3",
    "#8EA4A2",
    "#A4A7A4",
  },
  brights = {
    "#A4A7A4",
    "#E46876",
    "#87A987",
    "#E6C384",
    "#7FB4CA",
    "#938AA9",
    "#7AA89F",
    "#C5C9C7",
  }
}

return config
