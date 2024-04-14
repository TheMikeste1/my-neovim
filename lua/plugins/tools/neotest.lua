-- https://github.com/nvim-neotest/neotest
return {
	"nvim-neotest/neotest",
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-rust"),
				require("neotest-dotnet"),
				require("neotest-gtest"),
				require("neotest-bash"),
				require("neotest-python"),
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"rouge8/neotest-rust",
		"Issafalcon/neotest-dotnet",
		"alfaix/neotest-gtest",
		"rcasia/neotest-bash",
		"nvim-neotest/neotest-python",
		"nvim-neotest/nvim-nio",
	},
}
