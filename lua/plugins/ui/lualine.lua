local FILE_NONTYPES = {
	"fugitive",
	"TelescopePrompt",
	"OverseerForm",
	"OverseerList",
  "lazy"
}

---@return boolean
local function is_enabled_file()
	local filetype = vim.bo.filetype
	for _, nontype in ipairs(FILE_NONTYPES) do
		if filetype == nontype then
			return false
		end
	end
	return true
end

return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				globalstatus = true,
				disabled_filetypes = {
					statusline = {
						"alpha",
					},
				},
			},
			extensions = {
				"neo-tree",
				"trouble",
			},
			sections = {
				lualine_c = {
					{ "filetype", cond = is_enabled_file },
					{ "filename", cond = is_enabled_file },
				},
				lualine_x = {
					{
						"overseer",
					},
					{
						require("noice").api.status.message.get,
						cond = require("noice").api.status.message.has,
					},
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
					},
				},
			},
			inactive_winbar = {
				lualine_b = { { "filename", path = 1 } },
			},
			winbar = {
				lualine_b = { { "filename", path = 1 } },
				lualine_c = {
					{ "aerial", colored = true },
				},
			},
		})
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
}
