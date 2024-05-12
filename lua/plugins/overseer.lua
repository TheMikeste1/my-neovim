return {
	"stevearc/overseer.nvim",
	config = function()
		require("overseer").setup({
			task_list = {
				direction = "bottom",
			},
		})
	end,
	keys = {
		{
			"<C-t>",
			function()
				require("overseer").toggle()
			end,
		},
		{
			"<C-M-t>",
			function()
				require("overseer").run_template()
			end,
		},
	},
	cmd = {
		"OverseerOpen",
		"OverseerClose",
		"OverseerToggle",
		"OverseerSaveBundle",
		"OverseerLoadBundle",
		"OverseerDeleteBundle",
		"OverseerRunCmd",
		"OverseerRun",
		"OverseerInfo",
		"OverseerBuild",
		"OverseerQuickAction",
		"OverseerTaskAction",
		"OverseerClearCache",
	},
}
