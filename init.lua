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
require("vim-setup")
require("plugin_setup")
require("keymap")
require("filetype")
require("configure_theme")

require("after")

-- Recompile spell file if it updated
local spell_path = vim.fn.stdpath("config") .. "/spell"
local paths = vim.split(vim.fn.glob(spell_path .. "/*.add"), "\n")
for _, file in ipairs(paths) do
  -- Can we skip generation?
  local compiled_file = file .. ".spl"
  if vim.fn.filereadable(compiled_file) == 1 then
    local file_timestamp = vim.fn.getftime(file)
    local compiled_timestamp = vim.fn.getftime(compiled_file)
    if file_timestamp <= compiled_timestamp then
      goto continue
    end
  end

  vim.cmd("mkspell! " .. file)
  ::continue::
end

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  command = "wa",
})
