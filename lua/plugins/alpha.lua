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
			require("session_manager").load_last_session()
		end),
		dashboard.button("c", "  Configuration", "<cmd>cd ~/.config/nvim/ <CR>"),
		dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
		dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
	}
	return screen.config
end

return {
	"goolord/alpha-nvim",
	config = function()
		local alpha = require("alpha")
		alpha.setup(generate_dashboard())
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		"Shatur/neovim-session-manager",
	},
}
