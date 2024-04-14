return {
	"williamboman/mason.nvim",
	lazy = false,
	config = function(_, opts)
		require("mason").setup(opts)

		-- custom nvchad cmd to install all mason binaries listed https://github.com/NvChad/NvChad/blob/c80f3f0501800d02b0085ecc1f79bfc64327d01e/lua/plugins/init.lua#L137
		vim.api.nvim_create_user_command("MasonInstallAll", function()
			vim.inspect(vim.g.mason_binaries_list)
			if opts.ensure_installed and #opts.ensure_installed > 0 then
				vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
			end
		end, {})

		vim.g.mason_binaries_list = opts.ensure_installed
	end,
	opts = {
		ensure_installed = {
			-- C++
			"clangd",
			"clang-format",
			"codelldb",
			-- CMake
			"cmakelang",
			"cmakelint",
			"neocmakelsp",
			-- Lua
			"lua-language-server",
			-- Python
			"pyright",
			"debugpy",
		},
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
}
