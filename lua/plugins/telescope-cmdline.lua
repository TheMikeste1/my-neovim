return {
	"jonarrien/telescope-cmdline.nvim",
	config = function()
		require("telescope").load_extension("cmdline")
	end,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ ":", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
	},
}
