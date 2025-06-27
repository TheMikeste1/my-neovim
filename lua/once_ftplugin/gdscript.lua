-- We won't use the default style
if VSCODE then
  return
end

local dap = require("dap")
dap.adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

local cwd = vim.fn.getcwd()
if IS_WSL then
  local FileUtilities = require("utilities.file_utilities")
  cwd = FileUtilities.wslPathToWindows(cwd)
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
