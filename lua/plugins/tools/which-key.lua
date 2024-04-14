return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function(_, opts)
		vim.o.timeout = true
		vim.o.timeoutlen = 500
		require("which-key").setup(opts)
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
