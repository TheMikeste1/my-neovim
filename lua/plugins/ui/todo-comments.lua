return {
  "folke/todo-comments.nvim",
  enabled = false,
  config = true,
  opts = {
    keywords = {
      TODO = { alt = { "\\@todo", "\\@TODO" } },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
