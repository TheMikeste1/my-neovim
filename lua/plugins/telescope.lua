return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<C-p>",
			"<cmd>lua require('telescope.builtin').find_files()<CR>",
			desc = "Quick jump to files",
		},
		{
			"<M-C-F>",
			"<cmd>lua require('telescope.builtin').live_grep()<CR>",
			desc = "Search in files",
		},
		{
			"<C-f>",
			"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
			desc = "Search in current buffer",
		},
		{
			"<leader><leader>h",
			"<cmd>lua require('telescope.builtin').help_tags()<CR>",
			desc = "Search in help tags",
		},
		{
			"<leader><leader>g",
			"<cmd>lua require('telescope.builtin').git_files()<CR>",
			desc = "Search in git files",
		},
		{
			"<leader><leader>s",
			"<cmd>lua require('telescope.builtin').spell_suggest()<CR>",
			desc = "Search in spell suggest",
		},
		{
			"<leader><leader>c",
			"<cmd>lua require('telescope.builtin').commands()<CR>",
			desc = "Search in commands",
		},
		{
			"<leader><leader>t",
			"<cmd>lua require('telescope.builtin').treesitter()<CR>",
			desc = "Search in treesitter",
		},
		{
			"<leader><leader>m",
			"<cmd>lua require('telescope.builtin').marks()<CR>",
			desc = "Search in marks",
		},
	},
}
