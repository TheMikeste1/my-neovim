return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("ibl").setup()
	end,
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}
