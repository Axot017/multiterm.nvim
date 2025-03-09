local config = require("multiterm.config")
local logger = require("multiterm._utils.logger")
local term_manager = require("multiterm.term_manager")
local binder = require("multiterm._utils.binder")

local function get_selected_text()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  return table.concat(lines, "\n") .. "\n"
end

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

-- Send text to a terminal
M.send_text = function(binding, text)
  if binding == nil or #binding == 0 then
    logger.log(logger.levels.ERROR, "No binding provided")
    return
  end

  if text == nil or #text == 0 then
    logger.log(logger.levels.ERROR, "No text provided")
    return
  end

  term_manager.send_text(binding, text)
end

-- Send visual selection to a terminal
M.send_selection = function(binding)
  local text = get_selected_text()

  M.send_text(binding, text)
end

M.bind_send_selection = function()
  binder.bind(function(binding)
    M.send_selection(binding)
  end)
end

return M
