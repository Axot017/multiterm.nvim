local M = {}

M.bind = function(fn)
  vim.schedule(function()
    local key = vim.fn.getchar()
    local binding = vim.fn.nr2char(key)
    fn(binding)
  end)
end

return M
