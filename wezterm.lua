local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Kanagawa (Gogh)'
config.font = wezterm.font('HackNerdFont', { weight = 'Regular' })
config.font_size = 13.0

config.enable_tab_bar = false

config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

return config
