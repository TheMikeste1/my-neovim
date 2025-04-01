require("utilities.state")
local FileUtilities = require("utilities.file_utilities")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.loader.enable()

-- Set working directory
if vim.fn.argc() == 1 then
  local arg = vim.fn.argv()[1]
  -- If the argument is a non-existing directory, create it
  if arg:sub(-1) == "/" and not FileUtilities.isDirectory(arg) then
    -- Create the directory
    vim.fn.mkdir(arg, "p")
  end

  if FileUtilities.isDirectory(arg) then
    vim.cmd("cd " .. arg)
  end
end

require("vim_setup")
require("plugin_setup")
require("keymap")
require("filetype")
require("configure_theme")

-- TODO: Compile spell files: https://www.reddit.com/r/vim/comments/5zhpre/comment/df0xccw/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
