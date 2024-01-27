return {
  "chrisgrieser/nvim-spider",
  cond = true,
  keys = {
    {
      "<Leader>w",
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "o", "x" },
      { desc = "spider-w" },
    },
    {
      "<Leader>e",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      { desc = "Spider-e" },
    },
    {
      "<Leader>b",
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { "n", "o", "x" },
      { desc = "Spider-b" },
    },
    {
      "<Leader>ge",
      "<cmd>lua require('spider').motion('ge')<CR>",
      mode = { "n", "o", "x" },
      { desc = "Spider-ge" },
    },
  },
}
