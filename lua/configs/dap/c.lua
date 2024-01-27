---@return string path The path to the executable to run.
local function get_executable_path()
  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

---@param target cmakeseer.cmake.api.codemodel.Target The CMakeSeer target.
---@return dap.Configuration config
local function generate_target_configuration(target)
  local CmakeseerTarget = require("cmakeseer.cmake.api.codemodel.target")
  local executable_path = CmakeseerTarget.get_target_path(target)

  return {
    name = string.format("CMakeseer: Launch %s", target.name),
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerPath = "gdb",
    program = executable_path,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "enable pretty printing",
        ignoreFailures = false,
      },
    },
  }
end

---@return dap.Configuration[] configurations The configs provided by CMakeSeer.
local function generate_cmakeseer_configurations()
  local cmakeseer = require("cmakeseer")
  local cmakeseer_target = require("cmakeseer.cmake.api.codemodel.target")

  local configs = {}
  for _, target in ipairs(cmakeseer.get_targets()) do
    if target.type == cmakeseer_target.TargetType.Executable then
      local config = generate_target_configuration(target)
      table.insert(configs, config)
    end
  end
  return configs
end

local M = {}

function M.adapters()
  return {
    codelldb = {
      type = "executable",
      command = "codelldb",
    },
    cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fs.joinpath(
        vim.fn.stdpath("data"),
        "mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
      ),
    },
  }
end

---@return dap.Configuration
function M.configurations()
  local configs = generate_cmakeseer_configurations()
  table.insert(configs, {
    name = "Launch executable",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerPath = "gdb",
    program = get_executable_path,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "enable pretty printing",
        ignoreFailures = false,
      },
    },
  })

  return configs
end

return M
