return {
	"nvim-neo-tree/neo-tree.nvim",
	keys = {
		{
			"<leader><C-e>",
			function()
				require("neo-tree.command").execute({
					action = "focus",
					position = "left",
					reveal = true,
				})
			end,
			desc = "Explorer",
		},
		{
			"<leader><C-b>",
			function()
				require("neo-tree.command").execute({
					action = "show",
					position = "left",
					reveal = true,
					toggle = true,
				})
			end,
			desc = "Toggle sideview",
		},
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
				show_hidden_count = true,
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_by_name = {
					".git",
				},
				never_show = {},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",
		"s1n7ax/nvim-window-picker",
	},
}
