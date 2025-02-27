local health = vim.health or require("health")

local M = {}

local start = health.start or health.report_start
local ok = health.ok or health.report_ok
local warn = health.warn or health.report_warn
local error = health.error or health.report_error
local info = health.info or health.report_info

local function check_dependencies()
  start("Dependencies")
  
  -- Check Neovim version
  local nvim_version = vim.version()
  local version_string = string.format("%d.%d.%d", nvim_version.major, nvim_version.minor, nvim_version.patch)
  
  if nvim_version.major >= 0 and nvim_version.minor >= 5 then
    ok("Neovim version: " .. version_string)
  else
    warn("Neovim version: " .. version_string)
    info("multiterm.nvim works best with Neovim >= 0.5")
  end
  
  -- Check terminal feature
  if vim.fn.has('terminal') == 1 then
    ok("Terminal feature: available")
  else
    error("Terminal feature: not available")
    info("multiterm.nvim requires Neovim's terminal feature")
  end
  
  -- Check floating windows support
  if vim.fn.exists('*nvim_open_win') == 1 then
    ok("Floating windows: supported")
  else
    error("Floating windows: not supported")
    info("multiterm.nvim requires support for floating windows")
  end
end

local function check_configuration()
  start("Configuration")
  
  local config_loaded = pcall(require, "multiterm.config")
  
  if config_loaded then
    ok("Configuration module loaded")
  else
    error("Configuration module not loaded")
    info("Could not load multiterm.config module")
  end
  
  local utils_loaded = true
  utils_loaded = utils_loaded and pcall(require, "multiterm._utils.logger")
  utils_loaded = utils_loaded and pcall(require, "multiterm._utils.binder")
  utils_loaded = utils_loaded and pcall(require, "multiterm._utils.window")
  
  if utils_loaded then
    ok("Utility modules loaded")
  else
    error("Could not load one or more utility modules")
    info("Make sure all required files are properly installed")
  end
end

function M.check()
  check_dependencies()
  check_configuration()
end

return M