return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "codecompanion" },
  opts = {
    code = {
      sign = false,
      -- position = "right",
      -- width = "block",
      -- right_pad = 10,
      -- style = "normal",
      -- above = " ",
      -- below = " ",
    },
    heading = {
      sign = false,
      signs = {},
      border = false,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      width = "block",
    },
    checkbox = {
      enabled = true,
      custom = {
        info = { raw = "[I]", rendered = "󰙎 ", highlight = "TodoBgNOTE", scope_highlight = "@markup.underline" },
        code = { raw = "[p]", rendered = " ", highlight = "TodoBgWARN", scope_highlight = "@markup.underline" },
        quiz = { raw = "[t]", rendered = "󰠗 ", highlight = "TodoBgNOTE", scope_highlight = "@markup.underline" },
        cmd = { raw = "[c]", rendered = " ", highlight = "TodoBgTODO", scope_highlight = "@markup.underline" },
      },
    },
  },
}
