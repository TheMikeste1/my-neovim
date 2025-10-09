---@class opts TSConfig
function config(_, opts)
  require("nvim-treesitter.configs").setup(opts)
end

return {
  "nvim-treesitter/nvim-treesitter",
  cond = true,
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
