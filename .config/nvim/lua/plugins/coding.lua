return {
    -- mini-ai
    { "echasnovski/mini.ai", enabled = false },

    -- harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        opts = {
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4,
            },
            settings = {
                save_on_toggle = true,
            },
        },
        keys = function()
            local keys = {
                {
                    "<leader>a",
                    function()
                        require("harpoon"):list():add()
                    end,
                    desc = "Harpoon File",
                },
                {
                    "<leader>h",
                    function()
                        local harpoon = require("harpoon")
                        harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
                    end,
                    desc = "Harpoon Quick Menu",
                },
            }

            for i = 1, 5 do
                table.insert(keys, {
                    "<leader>" .. i,
                    function()
                        require("harpoon"):list():select(i)
                    end,
                    desc = "Harpoon to File " .. i,
                })
            end
            return keys
        end,
    },

    -- nvim-treesitter-context
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = function()
            return {
                mode = "cursor",
                max_lines = 3,
                trim_scope = "outer",
                min_window_height = 0,
                patterns = {
                    default = {
                        "class",
                        "function",
                        "method",
                        "for",
                        "while",
                        "if",
                        "switch",
                        "case",
                    },
                    -- Add language-specific patterns here if needed
                },
                line_numbers = true,
            }
        end,
        config = function(_, opts)
            require("treesitter-context").setup(opts)

            vim.schedule(function()
                vim.api.nvim_set_hl(0, "TreesitterContext", { link = "NormalFloat" })
            end)
        end,
    },
}
