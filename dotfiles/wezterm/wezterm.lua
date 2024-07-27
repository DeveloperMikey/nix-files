local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = 'GruvboxDark'
config.enable_tab_bar = false
config.enable_wayland = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.font_size = 9.0

return config
