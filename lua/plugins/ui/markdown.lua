--TODO: Tweak this to my preferences
-- From Will
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    ft = { "markdown", "codecompanion" },
    opts = {
      code = {
        sign = false,
        position = "right",
        width = "block",
        right_pad = 10,
        style = "normal",
        above = " ",
        below = " ",
      },
      heading = {
        sign = false,
        signs = {},
        border = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        width = "block",
      },
      indent = {
        enabled = true,
        skip_level = 1,
        skip_heading = false,
        icon = false,
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
  },
}
