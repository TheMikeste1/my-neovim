return {
	"airblade/vim-rooter",
	cond = true,
	event = "VeryLazy",
	config = function()
		vim.g.rooter_patterns = { ".git/", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" }
	end,
}
