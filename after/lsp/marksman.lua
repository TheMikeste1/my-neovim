local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

return {
  filetypes = { "markdown", "codecompanion" },
  capabilities = capabilities,
}
