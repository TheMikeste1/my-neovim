return {
  "stevearc/overseer.nvim",
  config = function()
    require("overseer").setup({
      task_list = {
        direction = "bottom",
      },
      templates = {
        "builtin",
        "cmakeseer",
      },
    })
  end,
  dependencies = {
    "cmakeseer.nvim",
  },
  keys = {
    {
      "<C-t>",
      function()
        require("overseer").toggle()
      end,
      desc = "Toggle Overseer",
    },
    {
      "<C-M-t>",
      function()
        require("overseer").run_template()
      end,
      desc = "Run Overseer template",
    },
  },
  cmd = {
    "OverseerOpen",
    "OverseerClose",
    "OverseerToggle",
    "OverseerSaveBundle",
    "OverseerLoadBundle",
    "OverseerDeleteBundle",
    "OverseerRunCmd",
    "OverseerRun",
    "OverseerInfo",
    "OverseerBuild",
    "OverseerQuickAction",
    "OverseerTaskAction",
    "OverseerClearCache",
  },
}
