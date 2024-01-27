local function init()
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<C-p>", builtin.find_files, {})
	vim.keymap.set("n", "<C-S-F>", builtin.live_grep, {})
	vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, {})
	vim.keymap.set("n", "<leader><leader>h", builtin.help_tags, {})
end

return {
	"nvim-telescope/telescope.nvim",

	dependencies = { "nvim-lua/plenary.nvim" },
	init = init,
}
