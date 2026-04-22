local vscode_kit_file = vim.fn.expand("~/.local/share/CMakeTools/cmake-tools-kits.json")

local function postconfigure()
  local dap = require("dap")
  local new_configurations = require("configs.dap.c").configurations()
  dap.configurations.c = new_configurations
  dap.configurations.cpp = new_configurations
end

return {
  "TheMikeste1/cmakeseer.nvim",
  event = "VeryLazy",
  -- lazy = false,
  priority = 10,
  dir = "~/projects/cmakeseer",
  opts = {
    kit_paths = {
      vscode_kit_file,
    },
    persist_file = vscode_kit_file,
    callbacks = {
      postconfigure = postconfigure,
    },
  },
  cmd = {
    "CMakeSeer",
  },
}
