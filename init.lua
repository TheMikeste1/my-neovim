require("utilities.state")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.loader.enable()

require("utilities.file_utilities")

-- Set working directory
if vim.fn.argc() == 1 then
	local arg = vim.fn.argv()[1]
	-- If the argument is a non-existing directory, create it
	if arg:sub(-1) == "/" and not IsDirectory(arg) then
		-- Create the directory
		vim.fn.mkdir(arg, "p")
	end

	if IsDirectory(arg) then
		vim.cmd("cd " .. arg)
	end
end

require("vim_setup")
require("plugin_setup")
require("keymap")
require("configure_theme")
