return {
	"nvim-lualine/lualine.nvim",

	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	config = function()
		require("lualine").setup({
			extensions = {
				"neo-tree",
				"trouble",
			},
			sections = {
				lualine_x = {
					{
						require("noice").api.status.message.get,
						cond = require("noice").api.status.message.has,
					},
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
					},
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
					},
				},
			},
			inactive_winbar = {
				lualine_b = { { "windows", show_filename_only = false } },
			},
			winbar = {
				lualine_b = { { "windows", show_filename_only = false } },
				lualine_c = {
					{ "aerial", colored = true },
				},
			},
		})
	end,
}
