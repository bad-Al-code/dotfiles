-- Set system clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.pumblend = 0

-- Scroll offset
vim.opt.scrolloff = 10

-- Netrw settings
vim.g.netrw_banner = 0 -- Hide banner
vim.g.netrw_browse_split = 0 -- Open files in the same window
vim.g.netrw_winsize = 25 -- Set explorer width to 25% of the screen

local M = {}

function M.setup()
  local colors = {
    bg = "#16171c",
    fg = "#7aa2f7",
    light_bg = "#3b4261",
    separator = "#3b4261",
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
      r = "REPLACE",
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

  -- Function to get relative file path
  local function relative_path()
    local filepath = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd()
    if filepath:find(cwd, 1, true) == 1 then
      return filepath:sub(#cwd + 2)
    end
    return filepath
  end

  _G.statusline = {
    mode = mode,
    filename = filename,
    relative_path = relative_path,
  }

  -- Statusline setup
  vim.o.statusline = table.concat({
    " %{luaeval('statusline.mode()')} ",
    "%{luaeval('statusline.relative_path()')}",
    "%m",
    "%=",
    "%l:%c ",
    "%p%% ",
  })

  -- Set global status line
  vim.o.laststatus = 3

  -- Set window separator
  vim.o.fillchars = "vert:│,horiz:─,eob: "
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.separator })
end

return M
