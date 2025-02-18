-- bootstrap lazy.nvim, LazyVim and your plugins
-- require("config.lazy")
-- require("config.options").setup()

vim.cmd([[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    highlight Folded guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])
vim.cmd([[
    " Set a dark background for the statusline
    highlight StatusLine guibg=#303446 guifg=#cdd6f4

    " Set the background color for the inactive statusline
    highlight StatusLineNC guibg=#1e1e2e guifg=#a0a8c3
]])

vim.cmd([[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
    augroup END
]])

vim.cmd([[
    autocmd BufWritePre * %s/\s\+$//e
]])

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.scrolloff = 12

vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.opt.signcolumn = "yes"

vim.opt.termguicolors = true

-- Function to simplify key mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })
map("n", "<leader>e", ":Ex<CR>", { noremap = true, silent = true })
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "<C-f>", ":silent !tmux neww tmux_sessionizer<CR>", opts)
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
map("v", "p", '"_dP', opts)
map("n", "<leader>h", ":noh<CR>", opts)
map("n", "<Esc>", ":noh<CR>", opts)
