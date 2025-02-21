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

config.font = wezterm.font("FantasqueSansMono Nerd Font")
-- config.color_scheme = "Vs Code Dark+ (Gogh)"
-- config.color_scheme = "Kanagawa Dragon (Gogh)"
-- config.color_scheme = "Vs Code Light+ (Gogh)"
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
-- config.window_background_opacity = 0.95
-- local root_name = "/home/badal/"
-- config.window_background_image = root_name .. ".dotfiles/screenshots/B.png"
-- config.window_background_image_hsb = {
-- 	brightness = 0.02,
-- 	saturation = 0.09,
-- }

-- config.text_background_opacity = 0.8

return config
