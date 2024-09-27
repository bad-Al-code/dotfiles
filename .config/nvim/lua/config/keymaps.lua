local Util = require("lazyvim.util")

local map = Util.safe_keymap_set

function ToggleNetrw()
  local netrw_buffer = nil

  -- Find if there's a netrw buffer
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == "netrw" then
      netrw_buffer = buf
      break
    end
  end

  if netrw_buffer then
    -- If netrw is open, close it
    vim.api.nvim_buf_delete(netrw_buffer, { force = true })
  else
    -- If netrw is not open, open it
    vim.cmd("Explore")
  end
end

-- Window management
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertically" })
map("n", "<leader>ss", "<cmd>split<cr>", { desc = "Split horizontally" })

-- show full file-path
map("n", "<leader>pa", "<cmd>echo expand('%:p')<cr>", { desc = "Full file name" })

map("n", "<leader>e", ":lua ToggleNetrw()<CR>", { noremap = true, silent = true, desc = "Toggle netrw" })

-- select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Copy to system clipboard
map("v", "<leader>yy", '"+y', { noremap = true, silent = true, desc = "Copy to system clipboard" })

-- Ctrl+U: Half-page up and center
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up and center" })

-- Ctrl+D: Half-page down and center
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down and center" })
