return {
	"folke/neodev.nvim",

	opts = {},
	config = function()
		require("neodev").setup({
			library = { plugins = { "nvim-dap-ui" }, types = true },
		})
	end,
	dependencies = {
		"neovim/nvim-lspconfig",
		"hrsh7th/nvim-cmp",
	},
}
