return {
  "nvim-treesitter/nvim-treesitter",
  cond = true,
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
  },
}
