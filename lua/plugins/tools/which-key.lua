return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
