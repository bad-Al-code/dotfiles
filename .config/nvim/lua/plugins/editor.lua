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
          refactoring.refactor(selected[0])
        end,
      },
    }
    fzf_lua.fzf_exec(results, opts)
  end
end

return {

  -- grug-far.nvim -> search/replace in multiple files
  { "MagicDuck/grug-far.nvim", enabled = false },

  -- disable flash
  {
    "folke/flash.nvim",
    enabled = false,
  },

  -- which key
  { "folke/which-key.nvim", enabled = false },

  -- indent-blankline.nvim
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- persistence.nvim
  { "folke/persistence.nvim", enabled = false },

  -- nvim-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- Optional image support for file preview: See `# Preview Mode` for more information.
      -- {"3rd/image.nvim", opts = {}},
      -- OR use snacks.nvim's image module:
      -- "folke/snacks.nvim",
    },

    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      -- add options here
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/directories
          hide_by_name = {
            --"node_modules"
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            --".gitignored",
          },
          always_show_by_pattern = { -- uses glob style patterns
            --".env*",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --".DS_Store",
            --"thumbs.db"
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
        follow_current_file = {
          enabled = false, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
            -- ["D"] = "fuzzy_sorter_directory",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
            ["o"] = {
              "show_help",
              nowait = false,
              config = { title = "Order by", prefix_key = "o" },
            },
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["og"] = { "order_by_git_status", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
            -- ['<key>'] = function(state) ... end,
          },
          fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
            ["<down>"] = "move_cursor_down",
            ["<C-n>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-p>"] = "move_cursor_up",
            ["<esc>"] = "close",
            ["<S-CR>"] = "close_keep_filter",
            ["<C-CR>"] = "close_clear_filter",
            ["<C-w>"] = { "<C-S-w>", raw = true },
            {
              -- normal mode mappings
              n = {
                ["j"] = "move_cursor_down",
                ["k"] = "move_cursor_up",
                ["<S-CR>"] = "close_keep_filter",
                ["<C-CR>"] = "close_clear_filter",
                ["<esc>"] = "close",
              },
            },
            -- ["<esc>"] = "noop", -- if you want to use normal mode
            -- ["key"] = function(state, scroll_padding) ... end,
          },
        },

        commands = {}, -- Add a custom command or override a global one using the same function name
      },
    },
  },

  -- nvim-cmp
  {
    "hrsh6th/nvim-cmp",
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
  -- {
  --     "ThePrimeagen/refactoring.nvim",
  --     event = { "BufReadPre", "BufNewFile" },
  --     dependencies = {
  --         "nvim-lua/plenary.nvim",
  --         "nvim-treesitter/nvim-treesitter",
  --     },
  --     keys = {
  --         { "<leader>r", "", desc = "+refactor", mode = { "n", "v" } },
  --         {
  --             "<leader>rs",
  --             pick,
  --             mode = "v",
  --             desc = "Refactor",
  --         },
  --         {
  --             "<leader>ri",
  --             function()
  --                 require("refactoring").refactor("Inline Variable")
  --             end,
  --             mode = { "n", "v" },
  --             desc = "Inline Variable",
  --         },
  --         {
  --             "<leader>rb",
  --             function()
  --                 require("refactoring").refactor("Extract Block")
  --             end,
  --             desc = "Extract Block",
  --         },
  --         {
  --             "<leader>rf",
  --             function()
  --                 require("refactoring").refactor("Extract Block To File")
  --             end,
  --             desc = "Extract Block To File",
  --         },
  --         {
  --             "<leader>rP",
  --             function()
  --                 require("refactoring").debug.printf({ below = false })
  --             end,
  --             desc = "Debug Print",
  --         },
  --         {
  --             "<leader>rp",
  --             function()
  --                 require("refactoring").debug.print_var({ normal = true })
  --             end,
  --             desc = "Debug Print Variable",
  --         },
  --         {
  --             "<leader>rc",
  --             function()
  --                 require("refactoring").debug.cleanup({})
  --             end,
  --             desc = "Debug Cleanup",
  --         },
  --         {
  --             "<leader>rf",
  --             function()
  --                 require("refactoring").refactor("Extract Function")
  --             end,
  --             mode = "v",
  --             desc = "Extract Function",
  --         },
  --         {
  --             "<leader>rF",
  --             function()
  --                 require("refactoring").refactor("Extract Function To File")
  --             end,
  --             mode = "v",
  --             desc = "Extract Function To File",
  --         },
  --         {
  --             "<leader>rx",
  --             function()
  --                 require("refactoring").refactor("Extract Variable")
  --             end,
  --             mode = "v",
  --             desc = "Extract Variable",
  --         },
  --         {
  --             "<leader>rp",
  --             function()
  --                 require("refactoring").debug.print_var()
  --             end,
  --             mode = "v",
  --             desc = "Debug Print Variable",
  --         },
  --     },
  --     opts = {
  --         prompt_func_return_type = {
  --             go = false,
  --             java = false,
  --             cpp = false,
  --             c = false,
  --             h = false,
  --             hpp = false,
  --             cxx = false,
  --         },
  --         prompt_func_param_type = {
  --             go = false,
  --             java = false,
  --             cpp = false,
  --             c = false,
  --             h = false,
  --             hpp = false,
  --             cxx = false,
  --         },
  --         printf_statements = {},
  --         print_var_statements = {},
  --         show_success_message = true, -- shows a message with information about the refactor on success
  --         -- i.e. [Refactor] Inlined 2 variable occurrences
  --     },
  --     config = function(_, opts)
  --         require("refactoring").setup(opts)
  --         if LazyVim.has("telescope.nvim") then
  --             LazyVim.on_load("telescope.nvim", function()
  --                 require("telescope").load_extension("refactoring")
  --             end)
  --         end
  --     end,
  -- },
}
