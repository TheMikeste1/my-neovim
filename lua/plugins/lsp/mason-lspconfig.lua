return {
  "williamboman/mason-lspconfig.nvim",
  config = function()

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      automatic_enable = {
        exclude = {
          "rust_analyzer",
        },
      },
      ensure_installed = {
        -- TODO
      },
    })
  end,
  dependencies = {
    "williamboman/mason.nvim",
    "folke/neoconf.nvim",
  },
}
