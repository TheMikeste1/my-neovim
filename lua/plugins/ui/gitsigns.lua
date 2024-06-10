return {
	"lewis6991/gitsigns.nvim",
	config = true,
	opts = {
		signs = {
			add = { text = "┃" },
			delete = { text = "-" },
		},
		current_line_blame = true,
		current_line_blame_opts = {
			delay = 250,
		},
		signcolumn = false,
		numhl = true,
	},
	event = "VeryLazy",
}
