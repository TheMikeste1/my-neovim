return {
  "garymjr/nvim-snippets",
  event = "VeryLazy",
  opts = {
    friendly_snippets = true,
    create_cmp_source = true,
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    "hrsh7th/nvim-cmp",
  },
}
