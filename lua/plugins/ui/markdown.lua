--TODO: Tweak this to my preferences
-- From Will
return {
  -- For markdown preview, see opts file
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    opts = function(_, opts)
      vim.g.mkdp_auto_close = 0
    end,
    -- config = function()
    --   -- vim.g.mkdp_auto_start = 1 -- Automatically start
    --   -- vim.g.mkdp_refresh_slow = 1 -- Update preview in real-time
    --   -- vim.g.mkdp_combine_preview = 1
    --   -- vim.g.mkdp_combine_preview_auto_refresh = 1
    -- end,
  },
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
