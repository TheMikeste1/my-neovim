require("core_ext.once_ftplugin.c")

if vim.g.vscode then
  return
end

local dap = require("dap")
dap.configurations.cpp = dap.configurations.c
