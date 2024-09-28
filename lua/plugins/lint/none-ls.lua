return {
	"nvimtools/none-ls.nvim",
	config = function()
		-- We'll use conform for formatting and null_ls for other stuff
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
        null_ls.builtins.code_actions.gitrebase,
				null_ls.builtins.code_actions.refactoring,
				null_ls.builtins.completion.vsnip,

				null_ls.builtins.completion.spell,
				null_ls.builtins.diagnostics.dotenv_linter,
				null_ls.builtins.diagnostics.editorconfig_checker,
				null_ls.builtins.diagnostics.todo_comments,
				null_ls.builtins.diagnostics.trail_space,
				null_ls.builtins.code_actions.refactoring,

				-- Ansible
				null_ls.builtins.diagnostics.ansiblelint,

				-- C++
				null_ls.builtins.diagnostics.cppcheck,

				-- CMake
				null_ls.builtins.diagnostics.cmake_lint,

				-- CSS
				null_ls.builtins.diagnostics.stylelint,

				-- Docker
				null_ls.builtins.diagnostics.hadolint,

				-- Fish
				null_ls.builtins.diagnostics.fish,

				-- HTML/XML
				null_ls.builtins.diagnostics.tidy,

				-- Make
				null_ls.builtins.diagnostics.checkmake,

				-- Markdown
        null_ls.builtins.diagnostics.markdownlint,
				null_ls.builtins.hover.dictionary,

				-- Python
				null_ls.builtins.diagnostics.pylint,
				null_ls.builtins.diagnostics.mypy,

				-- Shell/Bash
				null_ls.builtins.hover.printenv,
				null_ls.builtins.diagnostics.zsh,

				-- SQL
				null_ls.builtins.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "postgres" }, -- change to your dialect
				}),

				-- Web

				-- YAML
				null_ls.builtins.diagnostics.yamllint,
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"williamboman/mason.nvim",
	},
}
