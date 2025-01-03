local M = {}

local _default_config = {
  log_level = 4,
  window = {}
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
