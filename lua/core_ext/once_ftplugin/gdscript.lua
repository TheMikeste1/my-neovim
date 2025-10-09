-- We won't use the default style
if vim.g.vscode then
  return
end

local dap = require("dap")
dap.adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

local cwd = vim.fn.getcwd()
if vim.g.is_wsl then
  local FileUtilities = require("utilities.file_utilities")
  cwd = FileUtilities.wsl_path_to_windows(cwd)
end

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    scene = "current",
    project = cwd,
  },
}
