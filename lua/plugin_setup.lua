function InitializePlugins()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

InitializePlugins()

local plugin_folders = {
	{ import = "plugins" },
	{ import = "plugins.ide" },
	{ import = "plugins.ide.cmp-plugins" },
	{ import = "plugins.ide.dap-adapters" },
	{ import = "plugins.ide.treesitter-extensions" },
	{ import = "plugins.languages" },
	{ import = "themes" },
}

local options = {
	checker = {
		-- automatically check for plugin updates
		enabled = true,
	},
	change_detection = {
		notify = false,
	},
	defaults = {
    cond = not VSCODE,
  },
}

require("lazy").setup(plugin_folders, options)
