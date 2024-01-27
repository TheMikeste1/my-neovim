if VSCODE then
	return
end

local theme = "sonokai"

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	callback = function()
		-- Sign column
		-- We'll steal the background from the number line and use it as our background color
		-- There might be a better way to do this, but I don't know what that would be.
		local number_backgroud = vim.api.nvim_get_hl_by_name("SignColumn", true).background
		local number_background_string = nil
		if number_backgroud ~= nil then
			number_background_string = string.format("#%06x", number_backgroud)
		end

		-- DAP
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#993939", bg = number_background_string })
		vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = number_background_string })
		vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = number_background_string })

		-- GitSigns
		-- vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#374752", bg = number_background_string })

		-- Marks
		vim.api.nvim_set_hl(0, "MarkSignHL", { bg = number_background_string })

		-- Neotree Icons
		local fg_color = string.format("#%06x", vim.api.nvim_get_hl_by_name("DiagnosticSignError", true).foreground)
		vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = fg_color, bg = number_background_string })
		fg_color = string.format("#%06x", vim.api.nvim_get_hl_by_name("DiagnosticSignWarn", true).foreground)
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = fg_color, bg = number_background_string })
		fg_color = string.format("#%06x", vim.api.nvim_get_hl_by_name("DiagnosticSignInfo", true).foreground)
		vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = fg_color, bg = number_background_string })
		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#fff68f", bg = number_background_string })

		-- QuickScope
		vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#a6f25a", underline = true })
		vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#5af2f2", underline = true })
	end,
})

require(string.format("themes.%s", theme))
vim.cmd(string.format("colorscheme %s", theme))

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
