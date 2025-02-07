local pick = function()
    if LazyVim.pick.picker.name == "telescope" then
        return require("telescope").extensions.refactoring.refactors()
    elseif LazyVim.pick.picker.name == "fzf" then
        local fzf_lua = require("fzf-lua")
        local results = require("refactoring").get_refactors()
        local refactoring = require("refactoring")

        local opts = {
            fzf_opts = {},
            fzf_colors = true,
            actions = {
                ["default"] = function(selected)
                    refactoring.refactor(selected[1])
                end,
            },
        }
        fzf_lua.fzf_exec(results, opts)
    end
end

return {

    -- which key
    { "folke/which-key.nvim", enabled = false },

    -- disable flash
    {
        "folke/flash.nvim",
        enabled = false,
    },

    -- indent-blankline.nvim
    { "lukas-reineke/indent-blankline.nvim", enabled = false },

    -- grug-far.nvim -> search/replace in multiple files
    { "MagicDuck/grug-far.nvim", enabled = false },

    -- persistence.nvim
    { "folke/persistence.nvim", enabled = false },

    -- neo-tree
    -- { "nvim-neo-tree/neo-tree.nvim", enabled = false },
    {
        "nvim-neo-tree/neo-tree.nvim",
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
                        hide_dotfiles = false,
                        hide_gitignored = true,
                    },
                },
            })
        end,
    },

    -- snacks.nvim
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            notifier = {
                enabled = true,
                timeout = 1000,
            },

            style = "minimal",
        },
    },

    -- nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        opts = {
            window = {
                completion = {
                    border = "rounded",
                    scrollbar = "║",
                    winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
                },
                documentation = {
                    border = "rounded",
                    scrollbar = "║",
                    winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
                },
            },
        },
    },

    -- refactoring-nvim
    {
        "ThePrimeagen/refactoring.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>r", "", desc = "+refactor", mode = { "n", "v" } },
            {
                "<leader>rs",
                pick,
                mode = "v",
                desc = "Refactor",
            },
            {
                "<leader>ri",
                function()
                    require("refactoring").refactor("Inline Variable")
                end,
                mode = { "n", "v" },
                desc = "Inline Variable",
            },
            {
                "<leader>rb",
                function()
                    require("refactoring").refactor("Extract Block")
                end,
                desc = "Extract Block",
            },
            {
                "<leader>rf",
                function()
                    require("refactoring").refactor("Extract Block To File")
                end,
                desc = "Extract Block To File",
            },
            {
                "<leader>rP",
                function()
                    require("refactoring").debug.printf({ below = false })
                end,
                desc = "Debug Print",
            },
            {
                "<leader>rp",
                function()
                    require("refactoring").debug.print_var({ normal = true })
                end,
                desc = "Debug Print Variable",
            },
            {
                "<leader>rc",
                function()
                    require("refactoring").debug.cleanup({})
                end,
                desc = "Debug Cleanup",
            },
            {
                "<leader>rf",
                function()
                    require("refactoring").refactor("Extract Function")
                end,
                mode = "v",
                desc = "Extract Function",
            },
            {
                "<leader>rF",
                function()
                    require("refactoring").refactor("Extract Function To File")
                end,
                mode = "v",
                desc = "Extract Function To File",
            },
            {
                "<leader>rx",
                function()
                    require("refactoring").refactor("Extract Variable")
                end,
                mode = "v",
                desc = "Extract Variable",
            },
            {
                "<leader>rp",
                function()
                    require("refactoring").debug.print_var()
                end,
                mode = "v",
                desc = "Debug Print Variable",
            },
        },
        opts = {
            prompt_func_return_type = {
                go = false,
                java = false,
                cpp = false,
                c = false,
                h = false,
                hpp = false,
                cxx = false,
            },
            prompt_func_param_type = {
                go = false,
                java = false,
                cpp = false,
                c = false,
                h = false,
                hpp = false,
                cxx = false,
            },
            printf_statements = {},
            print_var_statements = {},
            show_success_message = true, -- shows a message with information about the refactor on success
            -- i.e. [Refactor] Inlined 3 variable occurrences
        },
        config = function(_, opts)
            require("refactoring").setup(opts)
            if LazyVim.has("telescope.nvim") then
                LazyVim.on_load("telescope.nvim", function()
                    require("telescope").load_extension("refactoring")
                end)
            end
        end,
    },
}
