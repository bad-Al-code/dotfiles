local Util = require("lazyvim.util")
return {

  -- bufferline disable
  { "akinsho/bufferline.nvim", enabled = false },

  -- lualine
  -- { "nvim-lualine/lualine.nvim", enabled = false },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = {
  --     options = {
  --       theme = "base16",
  --       -- theme = "iceberg",
  --     },
  --   },
  -- },

  -- dashboard
  { "nvimdev/dashboard-nvim", enabled = false },

  -- -- mini-icons
  -- { "echasnovski/mini.icons", enabled = false },

  -- noice
  -- {
  --     "folke/noice.nvim",
  --     opts = {
  --         presets = {
  --             lsp_doc_border = true,
  --         },
  --         routes = {
  --             {
  --                 view = "cmdline",
  --                 filter = { event = "msg_showmode" },
  --             },
  --         },
  --     },
  -- },
}
