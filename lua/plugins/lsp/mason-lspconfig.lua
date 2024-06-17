local function on_lua_init(client)
	local path = client.workspace_folders[1].name
	if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
		return true
	end

	client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
		runtime = {
			version = "LuaJIT",
		},
		diagnostics = {
			globals = {
				"vim",
				"require",
			},
		},
		workspace = {
			checkThirdParty = true,
			library = vim.api.nvim_get_runtime_file("", true),
		},
		doc = {
			privateName = { "^_" },
		},
		telemetry = {
			enable = false,
		},
	})

	client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	return true
end

return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			automatic_installation = true,
			handlers = {
				-- Default
				function(server_name)
					lspconfig[server_name].setup({ capabilities = capabilities })
				end,
				["rust_analyzer"] = function()
					lspconfig.rust_analyzer.setup({
						capabilities = capabilities,
						settings = {
							["rust-analyzer"] = {
								checkOnSave = {
									command = "clippy",
								},
							},
						},
					})
				end,
				["bashls"] = function()
					lspconfig.bashls.setup({
						capabilities = capabilities,
						filetypes = { "bash", "sh", "zsh" },
					})
				end,
				["clangd"] = function()
					lspconfig.clangd.setup({
						capabilities = capabilities,
						cmd = {
							"clangd",
							"--offset-encoding=utf-16",
						},
					})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_init = on_lua_init,
					})
				end,
			},
		})
	end,
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"folke/neoconf.nvim",
	},
}
