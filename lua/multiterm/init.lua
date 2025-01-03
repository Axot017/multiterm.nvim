local config = require("multiterm.config")
local logger = require("multiterm._utils.logger")
local term_manager = require("multiterm.term_manager")

local M = {}

M.setup = function(args)
  config.setup(args)
end

M.toggle = function(binding)
  if binding == nil or #binding == 0 then
    logger.log(logger.levels.ERROR, "No arg provided")
    return
  end

  term_manager.toggle(binding)
end

return M
