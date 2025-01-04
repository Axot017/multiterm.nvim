local M = {}

local default_width = math.floor(vim.o.columns * 0.8)
local default_height = math.floor(vim.o.lines * 0.8)

local _default_config = {
  log_level = 4,
  window = {
    relative = "editor",
    width = default_width,
    height = default_height,
    style = "minimal",
    border = "rounded",
    row = math.floor((vim.o.lines - default_height) / 2),
    col = math.floor((vim.o.columns - default_width) / 2),
  }
}

local _config = _default_config


M.setup = function(new_config)
  local c = new_config or {}

  _config = vim.tbl_extend("force", _default_config, c)
end

M.get = function()
  return _config
end

return M
