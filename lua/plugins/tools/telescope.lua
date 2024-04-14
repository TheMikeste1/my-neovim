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
	keys = require("keymaps.telescope"),
	opts = opts,
}
