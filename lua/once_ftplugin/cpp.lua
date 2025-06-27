require("once_ftplugin.c")

if VSCODE then
  return
end

local dap = require("dap")
local dap_config = require("configs.dap.c")
dap.adapters.cpp = dap_config.adapters()
dap.configurations.cpp = dap_config.configurations()
