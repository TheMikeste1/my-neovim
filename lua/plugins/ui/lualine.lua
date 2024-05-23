return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			extensions = {
				"neo-tree",
				"trouble",
			},
			sections = {
				lualine_c = {
					"filetype",
					"filename",
				},
				lualine_x = {
					{
						"overseer",
					},
					{
						require("noice").api.status.message.get,
						cond = require("noice").api.status.message.has,
					},
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
					},
				},
			},
			inactive_winbar = {
				lualine_b = { { "filename", path = 0 } },
			},
			winbar = {
				lualine_b = { { "filename", path = 0 } },
				lualine_c = {
					{ "aerial", colored = true },
				},
			},
		})
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
}
