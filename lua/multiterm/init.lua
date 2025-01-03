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

M.bind_toggle = function()
  vim.schedule(function()
    local key = vim.fn.getchar()
    local binding = vim.fn.nr2char(key)
    M.toggle(binding)
  end)
end

M.remove = function(binding)
  if binding == nil or #binding == 0 then
    logger.log(logger.levels.ERROR, "No arg provided")
    return
  end

  term_manager.remove(binding)
end

M.bind_remove = function()
  vim.schedule(function()
    local key = vim.fn.getchar()
    local binding = vim.fn.nr2char(key)
    M.remove(binding)
  end)
end

M.remove_all = function()
  term_manager.remove_all()
end

M.close_active = function()
  term_manager.close_active()
end

return M
