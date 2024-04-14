return {
	"RRethy/nvim-treesitter-textsubjects",
	cond = true,
	config = function()
    -- TODO: Extract these to the treesitter setup
		-- require("nvim-treesitter.configs").setup({
		-- 	textsubjects = {
		-- 		enable = true,
		-- 		prev_selection = ",", -- (Optional) keymap to select the previous selection
		-- 		keymaps = {
		-- 			["."] = "textsubjects-smart",
		-- 			[";"] = "textsubjects-container-outer",
		-- 			["i;"] = "textsubjects-container-inner",
		-- 		},
		-- 	},
		-- })
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	event = "VeryLazy",
}
