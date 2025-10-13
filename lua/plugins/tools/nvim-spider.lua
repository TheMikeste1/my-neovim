local move_leader = require("keymaps").move_leader

return {
  "chrisgrieser/nvim-spider",
  cond = true,
  keys = {
    {
      move_leader("w"),
      function()
        require("spider").motion("w")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider-w",
    },
    {
      move_leader("e"),
      function()
        require("spider").motion("e")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider-e",
    },
    {
      move_leader("b"),
      function()
        require("spider").motion("b")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider-b",
    },
    {
      move_leader("ge"),
      function()
        require("spider").motion("ge")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider-ge",
    },
  },
}
