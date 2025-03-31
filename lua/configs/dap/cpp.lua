---@return string path The path to the executable to run.
local function get_executable_path()
  local cmakeseer = require("cmakeseer")
  if not cmakeseer.is_cmake_project() then
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  end

  if not cmakeseer.project_is_configured() then
    vim.notify(
      "This is a CMake project, but the project isn't configured. Cannot identify which program to run.",
      vim.log.levels.WARN
    )
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  end

  -- TODO: List potential executables instead of just appending the build path
  return vim.fn.input("Path to executable: ", cmakeseer.get_build_directory() .. "/", "file")
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
      command = vim.fn.expand("~")
        .. "/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    },
  }
end

function M.configurations()
  return {
    {
      name = "Launch file",
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
    -- {
    --   {
    --     name = "Launch file",
    --     type = "codelldb",
    --     request = "launch",
    --     program = get_program_path,
    --     cwd = "${workspaceFolder}",
    --     stopOnEntry = false,
    --   },
    -- }
  }
end

return M
