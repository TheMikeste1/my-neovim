return {
	"RRethy/vim-illuminate",

	opts = {},
	config = function()
		require("illuminate").configure()
	end,
	event = "VeryLazy",
}
