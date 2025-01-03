local config = require("multiterm.config")
local logger = require("multiterm._utils.logger")
local window = require("multiterm._utils.window")

local state = {
  terms = {},
}

local function get_term(binding)
  return state.terms[binding] or {
    buffer = -1,
    window = -1,
  }
end

local function get_or_create_buffer(term)
  if vim.api.nvim_buf_is_valid(term.buffer) then
    logger.log(logger.levels.DEBUG, "Reusing existing buffer: " .. term.buffer)
    return term.buffer
  end

  logger.log(logger.levels.DEBUG, "Creating new buffer")
  return vim.api.nvim_create_buf(false, true)
end

local M = {}

M.toggle = function(binding)
  local term = get_term(binding)
  logger.log(logger.levels.DEBUG, "Current terminal " .. binding .. " state: " .. vim.inspect(term))

  if vim.api.nvim_win_is_valid(term.window) then
    vim.api.nvim_win_hide(term.window)
  else
    local buffer = get_or_create_buffer(term)
    local win = window.create_window(buffer, config.get().window)

    local new_term = {
      buffer = buffer,
      window = win,
    }
    state.terms[binding] = new_term

    if vim.bo[buffer].filetype ~= "terminal" then
      vim.cmd.terminal()
      vim.bo[buffer].buflisted = false
    end
  end
end

return M
