return {
  "lukas-reineke/indent-blankline.nvim",
  cond = false,
  config = function()
    require("ibl").setup()
  end,
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
