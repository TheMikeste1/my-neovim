local vscode_kit_file = vim.fn.expand("~/.local/share/CMakeTools/cmake-tools-kits.json")

local function postconfigure()
  local dap = require("dap")
  local new_configurations = require("configs.dap.c").configurations()
  dap.configurations.c = new_configurations
  dap.configurations.cpp = new_configurations
end

local function handle_api_command(opts)
  vim.notify("CMakeSeer opts: " .. vim.inspect(opts), vim.log.levels.DEBUG)
  if not opts.fargs then
    vim.notify("Missing args")
    return
  end

  if opts.fargs[1] == "select_kit" then
    require("cmakeseer").select_kit()
    return
  end

  if opts.fargs[1] == "select_variant" then
    require("cmakeseer").select_variant()
    return
  end

  vim.notify("Unknown CMakeSeer command: " .. opts.args)
end

return {
  "TheMikeste1/cmakeseer.nvim",
  lazy = false,
  priority = 10,
  dir = "~/projects/cmakeseer",
  config = function(_, opts)
    require("cmakeseer").setup(opts)
    vim.api.nvim_create_user_command("CMakeSeer", handle_api_command, {
      desc = "Access the CMakeSeer API",
      nargs = "*",
      complete = function(_, _)
        return { "select_kit", "select_variant" }
      end,
    })
  end,
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
