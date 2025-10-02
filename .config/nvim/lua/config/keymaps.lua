local Util = require("lazyvim.util")

local map = Util.safe_keymap_set

-- Window management
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertically" })
map("n", "<leader>ss", "<cmd>split<cr>", { desc = "Split horizontally" })

-- show full file-path
map("n", "<leader>pa", "<cmd>echo expand('%:p')<cr>", { desc = "Full file name" })

-- map("n", "<leader>e", ":lua ToggleNetrw()<CR>", { noremap = true, silent = true, desc = "Toggle netrw" })

-- select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Copy to system clipboard
map("v", "<leader>yy", '"+y', { noremap = true, silent = true, desc = "Copy to system clipboard" })

-- Ctrl+U: Half-page up and center
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up and center" })

-- Ctrl+D: Half-page down and center
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down and center" })

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.api.nvim_set_keymap("n", "<C-f>", ":silent !tmux neww tmux_sessionizer<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<C-f>",
  ":silent !exec tmux neww /usr/local/bin/tmux_sessionizer<CR>",
  { noremap = true, silent = true }
)
