local function generate_dashboard()
	local screen = require("alpha.themes.theta")
	local dashboard = require("alpha.themes.dashboard")

	screen.buttons.val = {
		{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
		{ type = "padding", val = 1 },
		dashboard.button("e", "  New file", "<cmd>ene<CR>"),
		dashboard.button("<C-p>", "󰈞  Find file"),
		dashboard.button("<M-C-F>", "󰊄  Live grep"),
		dashboard.button("s", "  Open last session", function()
			local cwd = vim.loop.cwd()
			if cwd then
				local session = require("session_manager.config").dir_to_session_filename(cwd)
				if session:exists() then
					require("session_manager").load_current_dir_session(true)
				else
					print("No session found for " .. cwd)
				end
			else
				print("Cannot load session; no cwd found")
			end
		end),
		dashboard.button("c", "  Configuration", function()
			vim.cmd.cd(vim.fn.stdpath("config"))
		end),
		dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
		dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
	}
	return screen.config
end

return {
	"goolord/alpha-nvim",
	init = function()
		if vim.fn.argc() == 0 then
			return
		end

		-- If the argument is a directory, start the dashboard
		local arg = vim.fn.argv()[1]
		if not IsDirectory(arg) then
			return
		end

		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			callback = function()
				local alpha = require("alpha")
				if alpha.default_config.opts.autostart then
					vim.cmd("Alpha")
				end
			end,
		})
	end,
	config = function()
		local alpha = require("alpha")
		alpha.setup(generate_dashboard())
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
}
