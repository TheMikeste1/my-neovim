-- Send the selected entry to the quickfix list and open the list.
-- @param prompt_buffer_number number: The prompt buffer number.
local function send_to_quickfix_list(prompt_buffer_number)
	require("telescope.actions").smart_send_to_qflist(prompt_buffer_number)
	require("telescope.builtin").quickfix()
end

-- Setup the telescope plugin.
-- @param _ table: The telescope plugin.
-- @param opts table: The telescope plugin options.
local function config(_, opts)
	require("telescope").setup(opts)
	require("telescope").load_extension("cmdline")
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "TelescopeResults",
		command = "setlocal nofoldenable",
	})
end

local keys = {
	{
		":",
		"<cmd>Telescope cmdline<cr>",
		desc = "Cmdline",
	},
	{
		"<C-p>",
		"<cmd>lua require('telescope.builtin').git_files()<CR>",
		desc = "Quick jump to git files",
	},
	{
		"<leader><leader>f",
		"<cmd>lua require('telescope.builtin').find_files()<CR>",
		desc = "Quick jump to all files",
	},
	{
		"<leader>ps",
		function()
			require("telescope.builtin").grep_string({
				search = vim.fn.input("Grep > "),
			})
		end,
		desc = "Search for word in files",
	},
	{
		"<M-C-F>",
		"<cmd>lua require('telescope.builtin').live_grep()<CR>",
		desc = "Search in files",
	},
	{
		"<C-f>",
		"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
		desc = "Search in current buffer",
	},
	{
		"<leader><leader>h",
		"<cmd>lua require('telescope.builtin').help_tags()<CR>",
		desc = "Search in help tags",
	},
	{
		"<leader><leader>g",
		"<cmd>lua require('telescope.builtin').git_files()<CR>",
		desc = "Search in git files",
	},
	{
		"<leader><leader>s",
		"<cmd>lua require('telescope.builtin').spell_suggest()<CR>",
		desc = "Search in spell suggest",
	},
	{
		"<leader><leader>c",
		"<cmd>lua require('telescope.builtin').commands()<CR>",
		desc = "Search in commands",
	},
	{
		"<leader><leader>t",
		"<cmd>lua require('telescope.builtin').treesitter()<CR>",
		desc = "Search in treesitter",
	},
	{
		"<leader><leader>m",
		"<cmd>lua require('telescope.builtin').marks()<CR>",
		desc = "Search in marks",
	},
}

local opts = {
	defaults = {
		mappings = {
			i = {
				["<M-C-q>"] = send_to_quickfix_list,
			},
			n = {
				["<M-C-q>"] = send_to_quickfix_list,
			},
		},
	},
	extensions = {
		cmdline = {
			picker = {
				border = true,
				borderchars = {
					preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
					results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
				},
				layout_config = {
					preview_cutoff = 1,
				},
				theme = "dropdown",
				layout_strategy = "center",
				results_title = false,
				sorting_strategy = "ascending",
				cache_picker = {
					disabled = true,
				},
			},
		},
	},
}

return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim", "jonarrien/telescope-cmdline.nvim" },
	config = config,
	keys = keys,
	opts = opts,
}
