local keys = {
  {
    "[c",
    function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end,
    desc = "Jump to top of current context",
  },
}

return {
  "nvim-treesitter/nvim-treesitter-context",
  cond = true,
  opts = { mode = "cursor", max_lines = 3 },
  keys = keys,
}
