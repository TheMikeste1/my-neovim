local rapid_leader = require("keymaps").rapid_leader

return {
  "chrisgrieser/nvim-spider",
  cond = true,
  keys = {
    {
      rapid_leader("w"),
      function()
        require("spider").motion("w")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider-w",
    },
    {
      rapid_leader("e"),
      function()
        require("spider").motion("e")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider-e",
    },
    {
      rapid_leader("b"),
      function()
        require("spider").motion("b")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider-b",
    },
    {
      rapid_leader("ge"),
      function()
        require("spider").motion("ge")
      end,
      mode = { "n", "o", "x" },
      desc = "Spider-ge",
    },
  },
}
