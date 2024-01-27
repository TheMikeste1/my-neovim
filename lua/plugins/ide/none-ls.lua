return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.completion.spell,
				null_ls.builtins.diagnostics.eslint,

				null_ls.builtins.formatting.stylua,

				-- Ansible
				null_ls.builtins.diagnostics.ansiblelint,

				-- Shell/Bash
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.code_actions.shellcheck,
				null_ls.builtins.formatting.shellharden,
				null_ls.builtins.formatting.beautysh,
				null_ls.builtins.hover.printenv,
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
