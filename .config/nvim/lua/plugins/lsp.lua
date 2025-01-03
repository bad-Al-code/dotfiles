-- lua/plugins/lsp.lua
return {
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
}
