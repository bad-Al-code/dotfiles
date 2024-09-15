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

function M.setup()
  setup_auto_netrw()
  -- Add any other autocommands here
end

return M
