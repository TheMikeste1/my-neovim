return {
	"ggandor/leap.nvim",
	cond = true,
	dependencies = {
		"tpope/vim-repeat",
	},
	config = function()
		require("leap").setup({})
	end,
	keys = {
		{
			"<leader>f",
			function()
				local current_window = vim.fn.win_getid()
				require("leap").leap({ target_windows = { current_window } })
			end,
			mode = {
				"v",
				"n",
			},
			desc = "Leap",
		},
	},
}
