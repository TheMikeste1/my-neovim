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
  init = function()
    vim.api.nvim_set_hl(0, "TreesitterContext", { fg = "#61afef" })
    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = true })
  end,
  cond = true,
  opts = { mode = "cursor", max_lines = 3 },
  keys = keys,
}
