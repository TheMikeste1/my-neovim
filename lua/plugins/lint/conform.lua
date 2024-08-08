return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<A-F>",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		-- Conform will run multiple formatters sequentially
		-- Use a sub-list to run only the first available formatter
		formatters_by_ft = {
			-- Build tools
			cmake = { "cmake_format" },
			-- Programming
			c = { "uncrustify", "clang-format" },
			cpp = { "uncrustify", "clang-format" },
			cs = { "uncrustify", "clang-format" },
			cuda = { "clang-format" },
			java = { "uncrustify", "clang-format" },
			proto = { "clang-format" },
			rust = { "rustfmt" },
			-- Scripting
			lua = { "stylua" },
			python = { "isort", { "blackd", "black" } },
			-- Data
			sql = { "sqlfluff" },
			-- Shell
			fish = { "fish_indent" },
			sh = { { "beautysh", "shfmt" }, "shellharden" },
			zsh = { "beautysh", "shellharden" },
			-- Web
			javascript = { "biome", { "prettierd", "prettier" } },
			typescript = { "biome", { "prettierd", "prettier" } },
			javascriptreact = { "biome", { "prettierd", "prettier" } },
			typescriptreact = { "biome", { "prettierd", "prettier" } },
			json = { "biome", { "prettierd", "prettier" } },
			jsonc = { "biome", { "prettierd", "prettier" } },
			scss = { "stylelint" },
			less = { "stylelint" },
			css = { "stylelint" },
			sass = { "stylelint" },
			xml = { "xmllint", "xmlformat" },
			xsd = { "xmllint", "xmlformat" },
			-- Config Files
			toml = { "taplo" },
			yaml = { "yamlfix", "yamlfmt" },
      -- Writing
      markdown = { "mdslw", "markdownlint", "mdformat" }
		},
		-- Set up format-on-save
		-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
			uncrustify = {
				env = {
					UNCRUSTIFY_CONFIG = vim.fn.expand("~") .. "/.githooks/config/precommit/uncrustify.cfg",
				},
			},
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
