local config = require("multiterm.config")
local M = {}

M.levels = {
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
}

function M.log(level, message)
  if level >= (config.get().log_level or M.levels.WARN) then
    vim.notify(message, level)
  end
end

return M
