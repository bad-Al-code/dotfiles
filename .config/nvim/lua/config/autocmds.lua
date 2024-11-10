local M = {}

-- Automatically open netrw when nvim starts with no files
local function setup_auto_netrw()
    local function open_netrw()
        if vim.fn.argc() == 0 then
            vim.cmd("Explore")
        end
    end

    vim.api.nvim_create_autocmd("VimEnter", {
        callback = open_netrw,
    })
end

-- Disable auto-formatting for .env files
local function disable_formatting_for_env_files()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "env",
        callback = function()
            -- Disable text wrapping and formatting for .env files
            vim.opt_local.formatoptions:remove("t") -- Don't auto-wrap text
            vim.opt_local.textwidth = 0 -- No auto line splitting
            vim.opt_local.wrap = true -- Enable line wrapping (optional)
        end,
    })
end

function M.setup()
    setup_auto_netrw()
    disable_formatting_for_env_files() -- Add the autocommand to disable formatting for .env files
    -- Add any other autocommands here
end

return M
