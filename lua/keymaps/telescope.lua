local mod = {}

-- Search for a word in files.
local function grep_search()
	require("telescope.builtin").grep_string({
		search = vim.fn.input("Grep > "),
	})
end

-- If the current directory is a git repository, use `git_files` otherwise use `find_files`
local function project_files()
	require("telescope.builtin").find_files({ hidden = false })
end

-- Send the selected entry to the quickfix list and open the list.
-- @param prompt_buffer_number number: The prompt buffer number.
local function send_to_quickfix_list(prompt_buffer_number)
	require("telescope.actions").smart_send_to_qflist(prompt_buffer_number)
	require("telescope.builtin").quickfix()
end

mod.mappings = {
	i = {
		["<M-C-q>"] = send_to_quickfix_list,
	},
	n = {
		["<M-C-q>"] = send_to_quickfix_list,
	},
}

mod.lazy_keys = {
	-- {
	-- 	":",
	-- 	"<cmd>Telescope cmdline<cr>",
	-- 	desc = "Cmdline",
	-- },
	{
		"<C-p>",
		project_files,
		desc = "Quick jump to project files",
	},
	{
		"<leader><leader>f",
		"<cmd>lua require('telescope.builtin').find_files({ no_ignore = true })<CR>",
		desc = "Quick jump to all files",
	},
	{
		"<leader>ps",
		grep_search,
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

return mod
