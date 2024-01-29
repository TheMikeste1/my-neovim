return {
	"ggandor/flit.nvim",
	cond = true,
	config = function()
		require("flit").setup({
			labeled_modes = "vn",
		})
	end,
	dependencies = {
		"ggandor/leap.nvim",
		"tpope/vim-repeat",
	},
}
