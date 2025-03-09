local config = require("multiterm.config")
local logger = require("multiterm._utils.logger")
local window = require("multiterm._utils.window")

local state = {
  terms = {},
  active_term = nil,
}

local function get_term(binding)
  return state.terms[binding] or {
    buffer = -1,
    window = -1,
    binding = binding,
  }
end

local function initialize_terminal_buffer(buffer)
  vim.cmd.terminal()
  vim.bo[buffer].buflisted = false
  vim.bo[buffer].filetype = "terminal"
end

local function is_terminal_buffer(buffer)
  return vim.bo[buffer].filetype == "terminal"
end

local function get_or_create_buffer(term)
  if vim.api.nvim_buf_is_valid(term.buffer) then
    logger.log(logger.levels.DEBUG, "Reusing existing buffer: " .. term.buffer)
    return term.buffer
  end

  logger.log(logger.levels.DEBUG, "Creating new buffer")

  local buffer = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_create_autocmd({ "BufWipeout", "BufDelete" }, {
    buffer = buffer,
    callback = function()
      if not is_terminal_buffer(buffer) then
        return -- Do nothing if it's not a terminal buffer
      end
      logger.log(logger.levels.DEBUG, "Terminal wiped out: " .. term.binding)
      if state.active_term == term then
        state.active_term = nil
      end
      state.terms[term.binding] = nil
    end,
  })

  return buffer
end

local function read_window_config()
  local window_config = config.get().window

  if type(window_config) == "function" then
    return window_config()
  end

  return window_config
end

local function open_terminal(term)
  logger.log(logger.levels.DEBUG, "Opening terminal: " .. term.binding)
  local buffer = get_or_create_buffer(term)
  local win = window.create(buffer, read_window_config())

  local new_term = {
    buffer = buffer,
    window = win,
    binding = term.binding,
  }
  state.terms[term.binding] = new_term

  if not is_terminal_buffer(buffer) then
    initialize_terminal_buffer(buffer)
  end

  state.active_term = term.binding
  vim.cmd('startinsert')
end

local function close_terminal(term)
  logger.log(logger.levels.DEBUG, "Closing terminal: " .. term.binding)
  window.hide(term.window)
  state.active_term = nil
end

local function is_termianl_open(term)
  return window.is_valid(term.window)
end

local M = {}

M.send_text = function(binding, text)
  local term = get_term(binding)
  logger.log(logger.levels.DEBUG, "Current terminal " .. binding .. " state: " .. vim.inspect(term))
  if state.active_term ~= nil and state.active_term ~= binding then
    close_terminal(state.terms[state.active_term])
    open_terminal(term)
  elseif not is_termianl_open(term) then
    open_terminal(term)
  end

  term = get_term(binding)

  local success, job_id = pcall(vim.api.nvim_buf_get_var, term.buffer, "terminal_job_id")
  if success and job_id then
    vim.api.nvim_chan_send(job_id, text)
  else
    logger.log(logger.levels.ERROR, "Failed to get terminal job ID for binding: " .. binding)
  end
end

M.toggle = function(binding)
  local term = get_term(binding)
  logger.log(logger.levels.DEBUG, "Current terminal " .. binding .. " state: " .. vim.inspect(term))
  if state.active_term ~= nil and state.active_term ~= binding then
    close_terminal(state.terms[state.active_term])
    open_terminal(term)
  elseif is_termianl_open(term) then
    close_terminal(term)
  else
    open_terminal(term)
  end
end

M.remove = function(binding)
  local term = get_term(binding)
  if is_termianl_open(term) then
    close_terminal(term)
  end

  if vim.api.nvim_buf_is_valid(term.buffer) then
    vim.api.nvim_buf_delete(term.buffer, { force = true })
  end

  state.terms[term.binding] = nil
end

M.remove_all = function()
  for _, term in pairs(state.terms) do
    M.remove(term.binding)
  end
end

M.close_active = function()
  if state.active_term ~= nil then
    close_terminal(state.terms[state.active_term])
  end
end

return M
