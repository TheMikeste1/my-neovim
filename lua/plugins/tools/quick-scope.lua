return {
  "unblevable/quick-scope",
  cond = true,
  config = function()
    vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#a6f25a", underline = true })
    vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#5af2f2", underline = true })
  end,
}
