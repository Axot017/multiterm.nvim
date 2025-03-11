local M = {}

M.bind = function(fn)
  vim.schedule(function()
    vim.api.nvim_echo({ { "Waiting for key input...", "WarningMsg" } }, false, {})
    local key = vim.fn.getchar()
    vim.api.nvim_echo({ { '', '' } }, false, {})
    local binding = vim.fn.nr2char(key)
    fn(binding)
  end)
end

return M
