return {
	"jonarrien/telescope-cmdline.nvim",
	config = function()
		require("telescope").load_extension("cmdline")
	end,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ ":", "<cmd>Telescope cmdline theme=dropdown<cr>", desc = "Cmdline" },
	},
}
