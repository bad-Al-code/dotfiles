local M = {}

-- General options
local function set_options()
  vim.opt.clipboard = "unnamedplus"
  vim.opt.pumblend = 0
  vim.opt.scrolloff = 10
end

-- Netrw settings
local function setup_netrw()
  vim.g.netrw_banner = 0
  vim.g.netrw_browse_split = 0
  vim.g.netrw_winsize = 20
  vim.g.netrw_list_hide = [[^\./$]]
end

-- Colors for statusline and window separators
local colors = {
  bg = "#24262b",
  fg = "#7aa2f7",
  light_bg = "#3b4261",
  separator = "#3b4261",
}

-- Statusline utility functions
local statusline_utils = {
  mode = function()
    local mode_map = {
      n = "NORMAL",
      i = "INSERT",
      v = "VISUAL",
      V = "V-LINE",
      r = "REPLACE",
      c = "COMMAND",
      t = "TERMINAL",
      [""] = "V-BLOCK",
    }
    return mode_map[vim.api.nvim_get_mode().mode] or "UNKNOWN"
  end,

  filename = function()
    local fname = vim.fn.expand("%:t")
    return fname ~= "" and fname or "[No Name]"
  end,

  relative_path = function()
    local filepath = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd()
    return filepath:find(cwd, 1, true) == 1 and filepath:sub(#cwd + 2) or filepath
  end,
}

-- Setup colors and highlights
local function setup_colors()
  vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.bg, fg = colors.fg })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = colors.light_bg, fg = colors.fg })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.separator })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = colors.bg })
end

-- Setup window separators
local function setup_window_separators()
  vim.o.fillchars = "vert:│,horiz:─,eob: "
end

-- Max line width setting
local function set_line_width()
  vim.opt.textwidth = 120
  vim.opt.colorcolumn = "120"
end

function M.setup()
  set_options()
  setup_netrw()
  setup_colors()
  setup_window_separators()
  set_line_width()
end

return M
