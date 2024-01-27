require("utilities.state")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.loader.enable()

require("utilities.file_utilities")

-- Set working directory
if vim.fn.argc() == 1 then
	-- If the argument is a non-existing directory, create it and open it in the current window
	if vim.fn.argv()[1]:sub(-1) == "/" and not IsDirectory(vim.fn.argv()[1]) then
		-- Remove the slash
		local path = vim.fn.argv()[1]:sub(1, -2)
		-- Create the directory
		vim.fn.mkdir(path, "p")
	end

	vim.cmd("cd %:h")
end

require("vim_setup")
require("plugin_setup")
require("keymap")
require("configure_theme")
