local move_leader = require("keymaps").move_leader

return {
  "chrisgrieser/nvim-spider",
  cond = true,
  keys = {
    {
      move_leader("w"),
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "o", "x" },
      desc = "Spider-w",
    },
    {
      move_leader("e"),
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      desc = "Spider-e",
    },
    {
      move_leader("b"),
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { "n", "o", "x" },
      desc = "Spider-b",
    },
    {
      move_leader("ge"),
      "<cmd>lua require('spider').motion('ge')<CR>",
      mode = { "n", "o", "x" },
      desc = "Spider-ge",
    },
  },
}
