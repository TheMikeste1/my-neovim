return {
  "garymjr/nvim-snippets",
  event = "VeryLazy",
  opts = {
    friendly_snippets = true,
    create_cmp_source = true,
    extended_filetypes = {
      sh = { "bash" },
      bash = { "sh" },
    },
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    "hrsh7th/nvim-cmp",
  },
}
