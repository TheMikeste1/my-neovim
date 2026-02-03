return {
  "stevearc/overseer.nvim",
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {
    task_list = {
      direction = "bottom",
    },
    templates = {
      "builtin",
      "cmakeseer",
    },
    keymaps = {
      ["<C-t>"] = false
    }
  },
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
        require("overseer").run_task({})
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
