---@module "nvim-treesitter"

local function config(_, opts)
  ---@type TSConfig opts
  require("nvim-treesitter").setup(opts)
  vim.treesitter.language.register("cosmos", { "cosmos" })
end

return {
  "nvim-treesitter/nvim-treesitter",
  cond = true,
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
  },
  opts = {
    auto_install = true,
    highlight = { enable = not vim.g.vscode },
    indent = { enable = not vim.g.vscode },
  },
  config = config,
}
