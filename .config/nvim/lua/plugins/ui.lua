local Util = require("lazyvim.util")
return {

    -- bufferline disable
    { "akinsho/bufferline.nvim", enabled = false },

    -- lualine
    { "nvim-lualine/lualine.nvim", enabled = false },

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
    -- {
    --   "rcarriga/nvim-notify",
    --   opts = {
    --     timeout = 1000,
    --     render = "compact",
    --     top_down = false,
    --   },
    -- },

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
