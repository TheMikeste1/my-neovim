local vscode_kit_file = vim.fn.expand("~/.local/share/CMakeTools/cmake-tools-kits.json")

local function handle_api_command(opts)
  vim.notify("CMakeSeer opts: " .. vim.inspect(opts), vim.log.levels.DEBUG)
  if opts.fargs and opts.fargs[1] == "select_kit" then
    require("cmakeseer").select_kit()
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
    vim.api.nvim_create_user_command(
      "CMakeSeer",
      handle_api_command,
      { desc = "Access the CMakeSeer API", nargs = "*" }
    )
  end,
  opts = {
    kit_paths = {
      vscode_kit_file,
    },
    persist_file = vscode_kit_file,
  },
  cmd = {
    "CMakeSeer",
  },
}
