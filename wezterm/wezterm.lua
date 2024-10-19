-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.term = "xterm-256color"
config.adjust_window_size_when_changing_font_size = false
config.window_padding = { left = 20, right = 15, top = 20, bottom = 20 }
config.font = wezterm.font("JetbrainsMono Nerd Font")
config.font_size = 17
config.line_height = 1.3
config.color_scheme = 'One Half Black (Gogh)'
config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.5
config.macos_window_background_blur = 15

-- and finally, return the configuration to wezterm
return config
