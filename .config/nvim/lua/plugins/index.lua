return {
  { "nvim-mini/mini.ai", enabled = false },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- catppuccin
  { "catppuccin/nvim", enabled = false },
  -- { "folke/tokyonight.nvim", enabled = false },

  -- {
  --
  --     "rebelot/kanagawa.nvim",
  --
  --     config = function()
  --         require("kanagawa").setup({
  --             terminalColors = true, -- define vim.g.terminal_color_{0,17}
  --             colors = { -- add/modify theme and palette colors
  --                 palette = {},
  --                 theme = { wave = {}, lotus = {}, dragon = {}, all = { ui = { bg_gutter = "none" } } },
  --             },
  --             theme = "dragon", -- Load "wave" theme when 'background' option is not set
  --             background = { -- map the value of 'background' option to a theme
  --                 dark = "dragon", -- try "dragon" !
  --                 light = "lotus",
  --             },
  --             overrides = function(colors)
  --                 local theme = colors.theme
  --                 return {
  --                     NormalFloat = { bg = "none" },
  --                     FloatBorder = { bg = "none" },
  --                     FloatTitle = { bg = "none" },
  --
  --                     -- Save an hlgroup with dark background and dimmed foreground
  --                     -- so that you can use it where your still want darker windows.
  --                     -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
  --                     NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
  --
  --                     -- Popular plugins that open floats will link to NormalFloat by default;
  --                     -- set their background accordingly if you wish to keep them dark and borderless
  --                     LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --                     MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --                 }
  --             end,
  --         })
  --     end,
  -- },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      light_style = "day",
      day_brightness = 0.01,
      transparent = true,
      terminal_colors = true,
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      dim_inactive = true,
      hide_inactive_statusline = false,
    },
  },

  { "MagicDuck/grug-far.nvim", enabled = false },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  { "folke/which-key.nvim", enabled = false },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Global LSP settings
      inlay_hints = {
        enabled = false,
      },

      -- Server-specific settings
      servers = {
        -- Golang configuration
        gopls = {
          settings = {
            gopls = {
              hints = {
                parameterNames = false,
                assignVariableTypes = false,
                compositeLiteralFields = false,
                constantValues = false,
                functionTypeParameters = false,
                rangeVariableTypes = false,
              },
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },

        -- TypeScript/JavaScript configuration
        tsserver = {
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "none",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayEnumMemberValueHints = false,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "none",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayEnumMemberValueHints = false,
              },
            },
          },
        },
      },
    },
  },
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvimdev/dashboard-nvim", enabled = false },

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
        timeout = 2000,
      },
      picker = {
        enabled = false,
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            follow = true,
          },
        },
        icons = {
          files = {
            enabled = false,
          },
          git = {
            enabled = false,
          },
        },
      },

      lazygit = {
        config = {
          gui = {
            nerdFontsVersion = "",
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
