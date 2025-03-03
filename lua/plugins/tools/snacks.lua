return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = true,
      },
    },
    input = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
  },
}
