-- set sytem clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.pumblend = 0

vim.opt.scrolloff = 10

-- Tokyonight-inspired statusline configuration
local M = {}

function M.setup()
  local colors = {
    bg = "#16171c", -- Use terminal background
    fg = "#7aa2f7", -- Tokyonight blue for text
    light_bg = "#3b4261", -- Slightly lighter than bg for inactive windows
    separator = "#3b4261", -- Color for window separators
  }

  -- Set highlight groups
  vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.bg, fg = colors.fg })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = colors.light_bg, fg = colors.fg })

  -- Function to get current mode
  local function mode()
    local mode_map = {
      n = "NORMAL",
      i = "INSERT",
      v = "VISUAL",
      V = "V-LINE",
      c = "COMMAND",
      t = "TERMINAL",
      [""] = "V-BLOCK",
    }
    return mode_map[vim.api.nvim_get_mode().mode] or "UNKNOWN"
  end

  -- Function to get file name
  local function filename()
    local fname = vim.fn.expand("%:t")
    if fname == "" then
      return "[No Name]"
    end
    return fname
  end

  -- Make functions globally accessible
  _G.statusline = {
    mode = mode,
    filename = filename,
  }

  -- Statusline setup
  vim.o.statusline = table.concat({
    " %{luaeval('statusline.mode()')} ", -- Current mode
    "%{expand('%:h')}", -- File path
    "/%{luaeval('statusline.filename()')} ", -- File name
    "%m", -- Modified flag
    "%=", -- Right align
    "%l:%c ", -- Line and column
    "%p%% ", -- Percentage through file
  })

  -- Set global status line
  vim.o.laststatus = 3

  -- Set window separator
  vim.o.fillchars = "vert:│,horiz:─,eob: "
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.separator })
end

return M
