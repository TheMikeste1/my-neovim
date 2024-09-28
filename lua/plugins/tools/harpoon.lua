return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add file to harpoon",
		},
		{
			"<M-Esc>", -- <C-M-[>
			function()
				local harpoon = require("harpoon")
				local conf = require("telescope.config").values
				local harpoon_files = harpoon:list()
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end,
			desc = "Open harpoon window",
		},
		{
			"<C-M-N>",
			function()
				local harpoon = require("harpoon")
				harpoon:list():next()
			end,
			desc = "Next harpoon file",
		},
		{
			"<C-M-P>",
			function()
				local harpoon = require("harpoon")
				harpoon:list():prev()
			end,
			desc = "Previous harpoon file",
		},
		{
			"<leader>1",
			function()
				local harpoon = require("harpoon")
				harpoon:list():select(1)
			end,
			desc = "First harpoon file",
		},
		{
			"<leader>2",
			function()
				local harpoon = require("harpoon")
				harpoon:list():select(2)
			end,
			desc = "Second harpoon file",
		},
		{
			"<leader>3",
			function()
				local harpoon = require("harpoon")
				harpoon:list():select(3)
			end,
			desc = "Third harpoon file",
		},
		{
			"<leader>4",
			function()
				local harpoon = require("harpoon")
				harpoon:list():select(4)
			end,
			desc = "Fourth harpoon file",
		},
	},
}
