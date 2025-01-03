local logger = require("multiterm._utils.logger")

local M = {}

M.create = function(buffer, opts)
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local window_config = {
    relative = "editor",
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
  }

  logger.log(logger.levels.DEBUG, "Creating window with config: " .. vim.inspect(window_config))

  local window = vim.api.nvim_open_win(buffer, true, window_config)

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
