---@return string path The path to the executable to run.
local function get_executable_path()
  local cwd = vim.fn.getcwd()
  local candidates = vim.fn.glob(cwd .. "/build/**/*", false, true)
  local executable_candidates = {}
  for _, candidate in ipairs(candidates) do
    local file_type = vim.fn.getftype(candidate)
    if file_type ~= "file" then
      goto continue
    end

    local perms = vim.fn.getfperm(candidate)
    if string.match(perms, "x") then
      table.insert(executable_candidates, candidate)
    end

    ::continue::
  end

  return vim.fn.input("Executable: ", executable_candidates[1] or (cwd .. "/"), "file")
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
    lldb = {
      type = "executable",
      command = function()
        local maybe_path = vim.fn.exepath("lldb-dap")
        return maybe_path ~= nil and maybe_path or "lldb-dap"
      end,
      name = "lldb",
    },
  }
end

---@return dap.Configuration
function M.configurations()
  local configs = {
    {
      name = "CPPDBG: Launch executable",
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
    },
    {
      name = "LLDB: Launch executable",
      type = "lldb",
      request = "launch",
      program = get_executable_path,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
      console = "integratedTerminal",
    },
    {
      name = "LLDB: Attach to process",
      type = "lldb",
      request = "attach",
      pid = require("dap.utils").pick_process,
      args = {},
    },
  }

  local cmakeseer_configs = generate_cmakeseer_configurations()
  configs = vim.list_extend(configs, cmakeseer_configs)

  -- table.sort(configs, function(a, b)
  --   return a.name < b.name
  -- end)
  return configs
end

return M
