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
    vim.fn.chdir(arg)

    -- Auto open dashboard
    vim.api.nvim_create_autocmd({ "UIEnter" }, {
      once = true,
      callback = function()
        require("snacks").dashboard({ buf = 1, win = 1000 })
      end,
    })
  end
end

require("vim_setup")
require("keymap")
require("filetype")
require("plugin_setup")
require("configure_theme")

require("once_ftplugin")
require("after")
