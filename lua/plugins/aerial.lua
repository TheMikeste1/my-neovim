return {
	"stevearc/aerial.nvim",
	opts = {
		attach_mode = "global",
		autojump = true,
		backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
		filter_kind = {
			"Class",
			"Constructor",
			"Enum",
			"Function",
			"Interface",
			"Module",
			"Method",
			"Struct",
		},
		show_guides = true,
	},
	config = function(_, opts)
		require("aerial").setup(opts)
		require("telescope").load_extension("aerial")
	end,
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<M-C-O>",
			function()
				require("telescope").extensions.aerial.aerial()
			end,
			{ "n", "v" },
		},
	},
}
