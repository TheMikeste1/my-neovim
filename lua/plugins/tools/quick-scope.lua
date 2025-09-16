return {
  "unblevable/quick-scope",
  cond = false,
  config = function()
    vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#a6f25a", underline = true })
    vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#5af2f2", underline = true })

    vim.api.nvim_create_autocmd({ "ColorScheme" }, {
      callback = function()
        vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#a6f25a", underline = true })
        vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#5af2f2", underline = true })
      end,
    })
  end,
}
