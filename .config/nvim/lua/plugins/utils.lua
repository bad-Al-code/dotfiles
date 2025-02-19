return {
    {
        "folke/snacks.nvim",
        opts = {
            animate = { enabled = false },
            dashboard = { enabled = false },
            debug = { enabled = false },
            dim = { enabled = false },
            explorer = {
                auto_close = true,
            },
            indent = { enabled = false },
            input = { enabled = false },
            notifier = {
                enabled = true,
                timeout = 500,
            },
            picker = {
                sources = {
                    explorer = {
                        hidden = true,
                        ignored = true,
                        follow = true,
                    },
                },
            },

            terminal = { enabled = false },
            zen = { enabled = false },
            scratch = { enabled = false },
            bufdelete = { enabled = false },
            gitbrowse = { enabled = false },
            profiler = { enabled = false },

            scroll = { enabled = false },
            statuscolumn = { enabled = false },
        },
    },
}
