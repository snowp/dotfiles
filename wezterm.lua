local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Kanagawa (Gogh)'
config.font = wezterm.font('HackNerdFont', { weight = 'Regular' })
config.font_size = 13.0

config.enable_tab_bar = false

config.window_decorations = 'RESIZE'

-- Opacity doesn't look great on MacOS so don't use it.

return config
