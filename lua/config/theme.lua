vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })

vim.diagnostic.config({
  update_in_insert = true,
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    linehl = {},
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
  severity_sort = true,
})

vim.api.nvim_set_hl(0, "SpellBad", { underline = true })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#993939" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ff942f" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#00b7e4" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#54cf3c" })

vim.cmd.colorscheme("terafox")
