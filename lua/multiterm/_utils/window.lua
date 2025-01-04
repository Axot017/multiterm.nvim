local logger = require("multiterm._utils.logger")

local M = {}

M.create = function(buffer, opts)
  logger.log(logger.levels.DEBUG, "Creating window with config: " .. vim.inspect(opts))

  local window = vim.api.nvim_open_win(buffer, true, opts)

  return window
end


M.hide = function(window)
  if M.is_valid then
    logger.log(logger.levels.DEBUG, "Hiding window: " .. window)
    vim.api.nvim_win_hide(window)
  else
    logger.log(logger.levels.WARN, "Tried to hide invalid window: " .. window)
  end
end

M.is_valid = function(window)
  return vim.api.nvim_win_is_valid(window)
end

return M
