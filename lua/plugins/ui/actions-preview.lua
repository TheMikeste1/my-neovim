return {
	"aznhe21/actions-preview.nvim",

	keys = {
		{
			"<C-N>", -- <C-.> is being sent as ^N
			function()
				require("actions-preview").code_actions()
			end,
			mode = {
				"v",
				"n",
			},
		},
	},
}
