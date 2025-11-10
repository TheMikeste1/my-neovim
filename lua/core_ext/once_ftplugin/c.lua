-- C++ will also execute this file
if vim.g.vscode then
  return
end

local dap = require("dap")
local dap_config = require("configs.dap.c")
dap.adapters = vim.tbl_extend('error', dap.adapters, dap_config.adapters())
dap.configurations.c = dap_config.configurations()
