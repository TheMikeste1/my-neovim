local mod = {}

-- Search for a word in files.
local function grep_search()
	local input = vim.fn.input("Grep > ")
	if input ~= "" then
		require("telescope.builtin").grep_string({ search = input })
	end
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
		function()
			require("telescope.builtin").find_files({ no_ignore = true, hidden = true })
		end,
		desc = "Quick jump to all files",
	},
	{
		"<leader>ps",
		grep_search,
		desc = "Search for word in files",
	},
	{
		"<leader><leader>r",
		function()
			require("telescope.builtin").registers()
		end,
		desc = "Show registers",
		mode = { "n", "x" },
	},
	{
		"<leader>rr",
		function()
			require("telescope").extensions.refactoring.refactors()
		end,
		desc = "Show refactors",
		mode = { "n", "x" },
	},
	{
		"<M-C-F>",
		function()
			require("telescope.builtin").live_grep()
		end,
		desc = "Search in files",
	},
	{
		"<C-f>",
		function()
			require("telescope.builtin").current_buffer_fuzzy_find()
		end,
		desc = "Search in current buffer",
	},
	{
		"<leader><leader>h",
		function()
			require("telescope.builtin").help_tags()
		end,
		desc = "Search in help tags",
	},
	{
		"<leader><leader>g",
		function()
			require("telescope.builtin").git_files()
		end,
		desc = "Search in git files",
	},
	{
		"<leader><leader>s",
		function()
			require("telescope.builtin").spell_suggest()
		end,
		desc = "Search in spell suggest",
	},
	{
		"<leader><leader>c",
		function()
			require("telescope.builtin").commands()
		end,
		desc = "Search in commands",
	},
	{
		"<leader><leader>T",
		function()
			require("telescope.builtin").treesitter()
		end,
		desc = "Search in treesitter",
	},
	{
		"<leader><leader>m",
		function()
			require("telescope.builtin").marks()
		end,
		desc = "Search in marks",
	},
	{
		"<leader><leader>q",
		function()
			require("telescope.builtin").quickfix()
		end,
		desc = "Open quickfix list",
	},
	{
		"<leader>xx",
		function()
			require("telescope.builtin").diagnostics(require("telescope.themes").get_ivy({}))
		end,
		desc = "Diagnostics",
	},
	{
		"<leader>xX",
		function()
			require("telescope.builtin").diagnostics(require("telescope.themes").get_ivy({ bufnr = 0 }))
		end,
		desc = "Buffer Diagnostics",
	},
}

return mod
