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
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
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
    --     program = function()
    --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    --     end,
    --     cwd = "${workspaceFolder}",
    --     stopOnEntry = false,
    --   },
    -- }
  }
end

return M
