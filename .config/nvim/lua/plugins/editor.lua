local Util = require("lazyvim.util")
return {

  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    opts = {
      window = {
        completion = { -- rounded border; thin-style scrollbar
          border = "rounded",
          scrollbar = "║",
          winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
        },
        documentation = { -- no border; native-style scrollbar
          border = "rounded",
          scrollbar = "║",
          winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
        },
      },
    },
  },

  -- disable flash
  {
    enabled = false,
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      search = {
        forward = true,
        multi_window = false,
        wrap = false,
        incremental = true,
      },
    },
  },

  -- neo-tree
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
}
