return {
  "ThePrimeagen/refactoring.nvim",
  event = "BufNew",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    show_success_message = true,
  },
}
