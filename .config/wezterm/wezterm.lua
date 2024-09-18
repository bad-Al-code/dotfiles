-------------------------------------------------------------------------------
--                          WezTerm Configuration
-------------------------------------------------------------------------------

local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-------------------------------------------------------------------------------
--                             General Config
-------------------------------------------------------------------------------
-- config.font = wezterm.font("IBMPlexMono-Regular")

config.font = wezterm.font("Dank Mono")
config.freetype_load_flags = "NO_HINTING"

config.font_size = 14
config.line_height = 1
config.dpi = 96.0

config.max_fps = 145
config.color_scheme = "tokyonight_night"
--config.color_scheme = "catppuccin-latte"
-- config.color_scheme = "tokyonight_day"
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.enable_scroll_bar = false
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
local root_name = "/home/badal/"
-- config.window_background_image = root_name .. ".dotfiles/screenshots/1.png"
config.window_background_image_hsb = {
	-- brightness = 0.9,
	-- saturation = 0.5,
}

config.text_background_opacity = 0.8

return config
