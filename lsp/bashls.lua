-- Override nvim-lspconfig TODO: See if these can be moved into after/lsp
vim.lsp.config("bashls", {
  filetypes = { "bash", "sh", "zsh" },
})

-- Defaults
return {}
