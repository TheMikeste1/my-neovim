return {
	"Badhi/nvim-treesitter-cpp-tools",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- Optional: Configuration
	opts = function()
		local options = {
			preview = {
				quit = "q", -- optional keymapping for quit preview
				accept = "<tab>", -- optional keymapping for accept preview
			},
			header_extension = "hpp", -- optional
			source_extension = "cpp", -- optional
		}
		return options
	end,
	-- End configuration
	config = true,
}
