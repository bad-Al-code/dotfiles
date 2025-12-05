-------------------------------------------------------------------------------
--                          WezTerm Configuration
-------------------------------------------------------------------------------
local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-------------------------------------------------------------------------------
--                             THEME SELECTOR
-------------------------------------------------------------------------------
local THEME = "light" -- Options: "dark" or "light"

-------------------------------------------------------------------------------
--                             Font Configuration
-------------------------------------------------------------------------------
config.font = wezterm.font("Geist Mono", { weight = "Regular" })
config.font_size = 12
-- config.line_height = 1.2
config.cell_width = 1.0
config.bold_brightens_ansi_colors = true

-- Font rules for bold, italic, etc.
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font("Geist Mono", { weight = "Bold" }),
	},
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font("Geist Mono", { style = "Italic" }),
	},
}

-------------------------------------------------------------------------------
--                        Color Schemes
-------------------------------------------------------------------------------
local color_schemes = {
	dark = {
		foreground = "#fafafa",
		background = "#0a0a0a",
		cursor_bg = "#fafafa",
		cursor_fg = "#0a0a0a",
		cursor_border = "#fafafa",
		selection_fg = "#fafafa",
		selection_bg = "#262626",

		scrollbar_thumb = "#262626",
		split = "#262626",

		ansi = {
			"#171717", -- black
			"#ef4444", -- red
			"#22c55e", -- green
			"#f59e0b", -- yellow
			"#3b82f6", -- blue
			"#a855f7", -- magenta
			"#06b6d4", -- cyan
			"#fafafa", -- white
		},
		brights = {
			"#404040", -- bright black
			"#f87171", -- bright red
			"#4ade80", -- bright green
			"#fbbf24", -- bright yellow
			"#60a5fa", -- bright blue
			"#c084fc", -- bright magenta
			"#22d3ee", -- bright cyan
			"#ffffff", -- bright white
		},

		tab_bar = {
			background = "#0a0a0a",
			active_tab = {
				bg_color = "#171717",
				fg_color = "#fafafa",
				intensity = "Bold",
			},
			inactive_tab = {
				bg_color = "#0a0a0a",
				fg_color = "#737373",
			},
			inactive_tab_hover = {
				bg_color = "#171717",
				fg_color = "#fafafa",
			},
			new_tab = {
				bg_color = "#0a0a0a",
				fg_color = "#737373",
			},
			new_tab_hover = {
				bg_color = "#171717",
				fg_color = "#fafafa",
			},
		},
	},

	light = {
		foreground = "#0a0a0a",
		background = "#fafafa",
		cursor_bg = "#0a0a0a",
		cursor_fg = "#fafafa",
		cursor_border = "#0a0a0a",
		selection_fg = "#0a0a0a",
		selection_bg = "#e5e5e5",

		scrollbar_thumb = "#e5e5e5",
		split = "#e5e5e5",

		ansi = {
			"#fafafa", -- black (inverted for light mode)
			"#dc2626", -- red
			"#16a34a", -- green
			"#ca8a04", -- yellow
			"#2563eb", -- blue
			"#9333ea", -- magenta
			"#0891b2", -- cyan
			"#0a0a0a", -- white (inverted for light mode)
		},
		brights = {
			"#d4d4d4", -- bright black
			"#ef4444", -- bright red
			"#22c55e", -- bright green
			"#f59e0b", -- bright yellow
			"#3b82f6", -- bright blue
			"#a855f7", -- bright magenta
			"#06b6d4", -- bright cyan
			"#171717", -- bright white
		},

		tab_bar = {
			background = "#fafafa",
			active_tab = {
				bg_color = "#ffffff",
				fg_color = "#0a0a0a",
				intensity = "Bold",
			},
			inactive_tab = {
				bg_color = "#fafafa",
				fg_color = "#737373",
			},
			inactive_tab_hover = {
				bg_color = "#f5f5f5",
				fg_color = "#0a0a0a",
			},
			new_tab = {
				bg_color = "#fafafa",
				fg_color = "#737373",
			},
			new_tab_hover = {
				bg_color = "#f5f5f5",
				fg_color = "#0a0a0a",
			},
		},
	},
}

-- Apply the selected theme
config.color_scheme = nil
config.colors = color_schemes[THEME]

-------------------------------------------------------------------------------
--                           Window Appearance
-------------------------------------------------------------------------------
config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

-- Blur effect (requires compositor support)
config.macos_window_background_blur = 20

-- Window background image (uncomment to use)
-- local root_name = "/home/badal/"
-- config.window_background_image = root_name .. "Downloads/planet.jpg"
-- config.window_background_image_hsb = {
-- 	brightness = 0.03,
-- 	saturation = 0.1,
-- }

-------------------------------------------------------------------------------
--                           Tab Bar Configuration
-------------------------------------------------------------------------------
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = true
config.tab_max_width = 32

-- Tab bar styling
config.tab_bar_style = {}

-- Custom tab title
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.tab_title
	if title and #title > 0 then
		title = title
	else
		title = tab.active_pane.title
	end

	local index = tab.tab_index + 1

	if tab.is_active then
		return {
			{ Text = " " .. index .. ": " .. title .. " " },
		}
	else
		return {
			{ Text = " " .. index .. ": " .. title .. " " },
		}
	end
end)

-------------------------------------------------------------------------------
--                           Scrollbar
-------------------------------------------------------------------------------
config.enable_scroll_bar = false
config.min_scroll_bar_height = "2cell"
config.scrollback_lines = 10000

-------------------------------------------------------------------------------
--                           Performance
-------------------------------------------------------------------------------
config.max_fps = 120
config.animation_fps = 60
config.cursor_blink_rate = 700
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-------------------------------------------------------------------------------
--                           Keybindings
-------------------------------------------------------------------------------
config.disable_default_key_bindings = false
config.keys = {
	-- Tab management
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

	-- Pane management
	{ key = "\\", mods = "CTRL", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CTRL", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "q", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },

	-- Zoom
	{ key = "z", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },

	-- Font size
	{ key = "+", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

	-- Copy/Paste

	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

	-- Search
	{ key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search({ CaseSensitiveString = "" }) },

	-- Clear scrollback
	{ key = "k", mods = "CTRL|ALT", action = wezterm.action.ClearScrollback("ScrollbackAndViewport") },
}

-- Mouse bindings
config.mouse_bindings = {
	-- Right click paste
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	-- CTRL+Click to open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-------------------------------------------------------------------------------
--                           Hyperlinks
-------------------------------------------------------------------------------
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Add rules for recognizing URLs
table.insert(config.hyperlink_rules, {
	regex = [[\b\w+://[^\s]+\b]],
	format = "$0",
})

-------------------------------------------------------------------------------
--                           Bell
-------------------------------------------------------------------------------
config.audible_bell = "Disabled"
-- config.visual_bell = {
-- 	fade_in_function = "EaseIn",
-- 	fade_in_duration_ms = 150,
-- 	fade_out_function = "EaseOut",
-- 	fade_out_duration_ms = 150,
-- }

--config.visual_bell = "Disabled"

-------------------------------------------------------------------------------
--                           Miscellaneous
-------------------------------------------------------------------------------
config.automatically_reload_config = true
config.check_for_updates = false
config.show_update_window = false
config.exit_behavior = "Close"
config.clean_exit_codes = { 130 }

-- Default shell
-- config.default_prog = { "/bin/bash" }

-- Working directory
-- config.default_cwd = "/home/badal"

return config
