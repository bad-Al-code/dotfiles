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

  -- neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- Optional image support for file preview
      -- {"3rd/image.nvim", opts = {}},
      -- "folke/snacks.nvim",
    },

    lazy = false,
    opts = {
      default_component_configs = {
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "",
          highlight = "NeoTreeFileIcon",
        },
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "",
            renamed = "",
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },

      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {},
          hide_by_pattern = {},
          always_show = {},
          always_show_by_pattern = {},
          never_show = {},
          never_show_by_pattern = {},
        },
        follow_current_file = {
          enabled = false,
          leave_dirs_open = false,
        },
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = false,
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter",
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
          },
          fuzzy_finder_mappings = {
            ["<down>"] = "move_cursor_down",
            ["<C-n>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-p>"] = "move_cursor_up",
            ["<esc>"] = "close",
            ["<S-CR>"] = "close_keep_filter",
            ["<C-CR>"] = "close_clear_filter",
            ["<C-w>"] = { "<C-S-w>", raw = true },
            n = {
              ["j"] = "move_cursor_down",
              ["k"] = "move_cursor_up",
              ["<S-CR>"] = "close_keep_filter",
              ["<C-CR>"] = "close_clear_filter",
              ["<esc>"] = "close",
            },
          },
        },
        commands = {},
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
