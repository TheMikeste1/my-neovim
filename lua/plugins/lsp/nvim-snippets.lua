return {
  "garymjr/nvim-snippets",
  event = "VeryLazy",
  opts = {
    friendly_snippets = true,
    create_cmp_source = true,
  },
  dependencies = {
    {
      -- I'll have to use this until the zig snippets are updated
      -- https://github.com/rafamadriz/friendly-snippets/pull/504
      -- https://github.com/rafamadriz/friendly-snippets/pull/509
      "gmassman/friendly-snippets",
      branch = "patch-1",
    },
    -- "rafamadriz/friendly-snippets"
  },
}
