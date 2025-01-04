local config = require("multiterm.config")
local logger = require("multiterm._utils.logger")
local term_manager = require("multiterm.term_manager")
local binder = require("multiterm._utils.binder")

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

M.bind_toggle = function()
  binder.bind(M.toggle)
end

M.remove = function(binding)
  if binding == nil or #binding == 0 then
    logger.log(logger.levels.ERROR, "No arg provided")
    return
  end

  term_manager.remove(binding)
end

M.bind_remove = function()
  binder.bind(M.remove)
end

M.remove_all = function()
  term_manager.remove_all()
end

M.close_active = function()
  term_manager.close_active()
end

return M
