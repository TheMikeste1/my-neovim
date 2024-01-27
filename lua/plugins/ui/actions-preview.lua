return {
  "aznhe21/actions-preview.nvim",
  keys = {
    {
      "<M-.>", -- <C-.> is being sent as ^N
      function()
        require("actions-preview").code_actions()
      end,
      desc = "Code action preview",
      mode = {
        "v",
        "n",
      },
    },
  },
}
