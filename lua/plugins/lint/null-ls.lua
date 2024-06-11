return {
	"nvimtools/none-ls.nvim",
	config = function()
		-- We'll use conform for formatting and null_ls for other stuff
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.code_actions.gitsigns.with({
					config = {
						filter_actions = function(title)
							return title:lower():match("blame") == nil -- filter out blame actions
						end,
					},
				}),
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
				-- null_ls.builtins.formatting.clang_format,
				-- null_ls.builtins.formatting.uncrustify,

				-- CMake
				null_ls.builtins.diagnostics.cmake_lint,
				-- null_ls.builtins.formatting.cmake_format,

				-- CSS
				null_ls.builtins.diagnostics.stylelint,
				-- null_ls.builtins.formatting.stylelint,

				-- Docker
				null_ls.builtins.diagnostics.hadolint,

				-- Fish
				null_ls.builtins.diagnostics.fish,
				-- null_ls.builtins.formatting.fish_indent,

				-- Groovy/Jenkins
				-- null_ls.builtins.diagnostics.npm_groovy_lint,
				-- null_ls.builtins.formatting.npm_groovy_lint,

				-- HTML/XML
				null_ls.builtins.diagnostics.tidy,
				-- null_ls.builtins.formatting.tidy,

				-- Lua
				null_ls.builtins.diagnostics.selene,
				-- null_ls.builtins.formatting.stylua,

				-- Make
				null_ls.builtins.diagnostics.checkmake,

				-- Markdown
				null_ls.builtins.hover.dictionary,

				-- Python
				null_ls.builtins.diagnostics.pylint,
				null_ls.builtins.diagnostics.mypy,
				-- null_ls.builtins.formatting.black,
				-- null_ls.builtins.formatting.isort,

				-- Shell/Bash
				-- null_ls.builtins.formatting.shellharden,
				-- null_ls.builtins.formatting.shfmt,
				null_ls.builtins.hover.printenv,
				null_ls.builtins.diagnostics.zsh,

				-- SQL
				null_ls.builtins.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "postgres" }, -- change to your dialect
				}),
				-- null_ls.builtins.formatting.sqlfluff.with({
				-- 	extra_args = { "--dialect", "postgres" }, -- change to your dialect
				-- }),

				-- Web
				-- null_ls.builtins.formatting.biome,
				-- null_ls.builtins.formatting.prettier,

				-- YAML
				null_ls.builtins.diagnostics.yamllint,
				-- null_ls.builtins.formatting.yamlfix,
				-- null_ls.builtins.formatting.yamlfmt,
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"williamboman/mason.nvim",
	},
}
