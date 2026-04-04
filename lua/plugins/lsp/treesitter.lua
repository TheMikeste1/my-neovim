---@class opts TSConfig
function config(_, opts)
  require("nvim-treesitter").setup(opts)

  vim.treesitter.language.register("cosmos", { "cosmos" })
end

return {
  "nvim-treesitter/nvim-treesitter",
  cond = true,
  branch = "main",
  build = ":TSUpdate",
  cmd = { "TSUpdateSync" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
  },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    auto_install = true,
    highlight = { enable = not vim.g.vscode },
    indent = { enable = not vim.g.vscode },
  },
  config = config,
}
