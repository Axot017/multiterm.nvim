local logger = require("multiterm._utils.logger")

local M = {}

--- Creates a new floating window.
-- @param buffer number: The buffer to use for the window.
-- @param opts table: Options for creating the window.
-- @field width number: The width of the window (optional).
-- @field height number: The height of the window (optional).
-- @return number: The window ID.
M.create_window = function(buffer, opts)
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

return M
