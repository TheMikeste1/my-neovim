return {
	"mrcjkb/rustaceanvim",
	-- cond = false,
	lazy = false,
	event = { "BufRead Cargo.toml" },
	ft = { "rust" },
	init = function()
		vim.g.rustaceanvim = {
			server = {
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						checkOnSave = true,
						check = {
							command = "clippy",
						},
					},
				},
			},
			tools = {
				hover_actions = {
					replace_builtin_hover = false,
				},
			},
		}
	end,
}
