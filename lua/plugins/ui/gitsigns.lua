return {
  "lewis6991/gitsigns.nvim",
  config = true,
  opts = {
    signs = {
      add = { text = "┃" },
      delete = { text = "-" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 250,
      virt_text_priority = 100,
      virt_text_pos = "right_align",
    },
    signcolumn = false,
    numhl = true,
  },
  event = "VeryLazy",
}
