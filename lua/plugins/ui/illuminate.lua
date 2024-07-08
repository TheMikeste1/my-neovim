return {
	"RRethy/vim-illuminate",
	opts = {},
	config = function()
		require("illuminate").configure({
			large_file_cutoff = 10000,
		})
	end,
	event = "VeryLazy",
}
