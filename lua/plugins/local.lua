local vscode_kit_file = vim.fn.expand("~/.local/share/CMakeTools/cmake-tools-kits.json")

return {
  "TheMikeste1/cmakeseer.nvim",
  dir = "~/projects/cmakeseer",
  opts = {
    kit_paths = {
      vscode_kit_file,
    },
    persist_file = vscode_kit_file,
  },
}
