require("utilities.state")

if VSCODE then
  return
end

local theme = "nordfox"

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })

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

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function()
    -- Sign column
    -- We'll steal the background from the number line and use it as our background color
    -- There might be a better way to do this, but I don't know what that would be.
    local number_backgroud = vim.api.nvim_get_hl(0, { name = "SignColumn" }).bg
    local number_background_string = nil
    if number_backgroud ~= nil then
      number_background_string = string.format("#%06x", number_backgroud)
    end

    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#993939" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ff942f" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#00b7e4" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#54cf3c" })

    -- DAP
    vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#993939", bg = number_background_string })
    vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = number_background_string })
    vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = number_background_string })

    -- treesitter-context
    vim.api.nvim_set_hl(0, "TreesitterContext", { fg = "#61afef", bg = number_background_string })
    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = true })

    -- Marks
    vim.api.nvim_set_hl(0, "MarkSignHL", { bg = number_background_string })

    -- QuickScope
    vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#a6f25a", underline = true })
    vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#5af2f2", underline = true })

    -- Cmp
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
  end,
})

vim.cmd.colorscheme(theme)
