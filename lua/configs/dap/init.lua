local cpp_config = require("configs.dap.cpp")

local M = {}

function M.adapters()
  local adapters = {}
  local new_adapters = {}
  new_adapters = cpp_config.adapters()
  adapters = vim.tbl_extend("error", adapters, new_adapters)
  return adapters
end

---@return dap.Configuration
function M.configurations()
  local configurations = {}
  local new_configurations = {}
  new_configurations = cpp_config.configurations()
  configurations.cpp = new_configurations
  configurations.c = configurations.cpp
  return configurations
end

return M
