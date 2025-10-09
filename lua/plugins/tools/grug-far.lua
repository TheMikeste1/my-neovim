local leader = require("keymaps").leader

return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup()
  end,
  keys = {
    {
      leader("s"),
      function()
        require("grug-far").open()
      end,
      mode = "n",
      desc = "Find and replace",
    },
    {
      leader("s"),
      function()
        require("grug-far").with_visual_selection()
      end,
      mode = "v",
      desc = "Find and replace selection",
    },
  },
}
