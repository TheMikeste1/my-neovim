local function config()
	require("toggleterm").setup({
		open_mapping = [[<C-\>]],
		direction = "horizontal",
	})
end

return {
	"akinsho/toggleterm.nvim",

	config = config,
	event = "VeryLazy",
}
