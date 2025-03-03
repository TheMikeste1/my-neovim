return {
  "nvim-pack/nvim-spectre",
  cond = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>S",
      "<cmd>lua require('spectre').toggle()<CR>",
    },
  },
}
