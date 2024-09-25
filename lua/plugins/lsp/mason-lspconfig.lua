local function on_lua_nonvim_init(client, path)
	return true
end

local function on_lua_vim_init(client, path)
	if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
		local file_path = nil
		if vim.loop.fs_stat(path .. "/.luarc.json") then
			file_path = path .. "/.luarc.json"
		elseif vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			file_path = path .. "/.luarc.jsonc"
		end

		if file_path ~= nil then
			local file = io.open(file_path, "r")
			if file == nil then
				vim.notify("Unable to read luarc file `" .. file_path .. "`", vim.log.levels.ERROR)
			else
				local file_contents = file:read("a")
				file:close()

				client.config.settings.Lua = vim.json.decode(file_contents)
			end
		end
	end

	client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
		runtime = {
			version = "LuaJIT",
		},
		diagnostics = {
			disabled = { "mixed_table" },
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

local function on_lua_init(client)
	local path = client.workspace_folders[1].name
	local config_path = vim.fn.stdpath("config")[1]
	if path == config_path then
		return on_lua_nonvim_init(client, path)
	else
		return on_lua_vim_init(client, path)
	end
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
								checkOnSave = true,
								check = {
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
