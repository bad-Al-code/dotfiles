local Util = require("lazyvim.util")
return {

  -- bufferline disable
  { "akinsho/bufferline.nvim", enabled = false },

  -- lualine
  { "nvim-lualine/lualine.nvim", enabled = false },

  -- which key
  {
    { "folke/which-key.nvim", enabled = false },
  },

  -- dashboard
  { "nvimdev/dashboard-nvim", enabled = false },

  -- mini-icons
  { "echasnovski/mini.icons", enabled = false },

  -- noice
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      routes = {
        {
          view = "cmdline",
          filter = { event = "msg_showmode" },
        },
      },
    },
  },

  -- notify
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 100,
      background_colour = "#000000",
      stages = "fade",
      render = "compact",
    },
  },

  -- tailwind-colorizer-cmp
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },

  -- mini-indentscope
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "LazyFile",
    opts = {
      options = { try_as_border = true },
    },
  },
}
