local function on_lua_init(client)
	local path = client.workspace_folders[1].name
	if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
		client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = true,
					library = vim.api.nvim_get_runtime_file("", true),
				},
			},
		})

		client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	end
	return true
end

return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("mason-lspconfig").setup({
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
