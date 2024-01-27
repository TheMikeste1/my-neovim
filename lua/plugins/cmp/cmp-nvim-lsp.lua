return {
  "hrsh7th/cmp-nvim-lsp",
  config = function()
    require("cmp_nvim_lsp").setup({})
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end,
}
