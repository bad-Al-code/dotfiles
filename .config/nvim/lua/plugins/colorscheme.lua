return {

    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "kanagawa",
        },
    },

    -- catppuccin
    { "catppuccin/nvim", enabled = false },
    { "folke/tokyonight.nvim", enabled = false },

    {

        "rebelot/kanagawa.nvim",

        config = function()
            require("kanagawa").setup({
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = { -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = { ui = { bg_gutter = "none" } } },
                },
                theme = "dragon", -- Load "wave" theme when 'background' option is not set
                background = { -- map the value of 'background' option to a theme
                    dark = "dragon", -- try "dragon" !
                    light = "lotus",
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    }
                end,
            })
        end,
    },

    -- {
    --   "folke/tokyonight.nvim",
    --   lazy = false,
    --   priority = 1000,
    --   opts = {
    --     style = "night",
    --     light_style = "day",
    --     transparent = true,
    --     terminal_colors = true,
    --     styles = {
    --       -- Style to be applied to different syntax groups
    --       -- Value is any valid attr-list value for `:help nvim_set_hl`
    --       comments = { italic = true },
    --       keywords = { italic = true },
    --       functions = {},
    --       variables = {},
    --       sidebars = "transparent", -- style for sidebars, see below
    --       floats = "transparent", -- style for floating windows
    --     },
    --     dim_inactive = true,
    --     hide_inactive_statusline = false,
    --   },
    -- },
}
