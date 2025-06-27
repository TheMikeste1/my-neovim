-- C++ will also execute this file
if VSCODE then
  return
end

local dap = require("dap")
local dap_config = require("configs.dap.c")
dap.adapters.c = dap_config.adapters()
dap.configurations.c = dap_config.configurations()
