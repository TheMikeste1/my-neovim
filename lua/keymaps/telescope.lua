local function grep_search()
	require("telescope.builtin").grep_string({
		search = vim.fn.input("Grep > "),
	})
end

-- If the current directory is a git repository, use `git_files` otherwise use `find_files`
local function project_files()
	local ret = vim.system({ "git", "status" }):wait()
  print(vim.inspect(ret))
	if ret.code == 0 then
		require("telescope.builtin").git_files()
	else
		require("telescope.builtin").find_files()
	end
end

return {
	{
		":",
		"<cmd>Telescope cmdline<cr>",
		desc = "Cmdline",
	},
	{
		"<C-p>",
		project_files,
		desc = "Quick jump to project files",
	},
	{
		"<leader><leader>f",
		"<cmd>lua require('telescope.builtin').find_files()<CR>",
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
