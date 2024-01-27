return {
  "rcarriga/nvim-notify",
  event = "VeryLazy", -- VeryLazy to dodge flickering with messages before nvim is loaded
  config = function(_, opts)
    require("notify").setup(opts)
    vim.notify = require("notify")
  end,
  opts = {
    minimum_width = 8,
    render = "wrapped-compact",
    timeout = 2000,
    top_down = false,
  },
}
