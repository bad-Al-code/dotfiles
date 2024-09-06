-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Custom statusline colors to match tmux configuration
local tokyonight_bg = "#16171c" -- Default background for TokyoNight
local blue = "#7aa2f7" -- TokyoNight blue
local light_bg = "#3b4261" -- Slightly lighter than background for inactive panes

-- Set the highlight for statusline
vim.api.nvim_set_hl(0, "StatusLine", { bg = tokyonight_bg, fg = blue }) -- Active window
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = light_bg, fg = blue })
