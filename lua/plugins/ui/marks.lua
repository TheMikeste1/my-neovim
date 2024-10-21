return {
	"chentoast/marks.nvim",
	event = "VeryLazy",
	config = true,
	opts = {
		builtin_marks = { ".", "<", ">", "^", "`", "[", "]" },
		excluded_filetypes = { "DressingInput", "noice", "Telescope", "Neotest Summary", "" },
		excluded_buftypes = { "nofile" },
	},
}
