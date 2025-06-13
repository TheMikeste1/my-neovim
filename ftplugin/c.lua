-- C++ will also execute this file
vim.fn.mkdir(".cache/cppcheck", "p")

vim.keymap.set("n", "<M-o>", function()
  require("clangd_extensions.switch_source_header").switch_source_header()
end, { noremap = true, desc = "Switch between source and header" })

local dap = require("dap")
local dap_config = require("configs.dap.c")
dap.adapters.c = dap_config.adapters()
dap.configurations.c = dap_config.configurations()
