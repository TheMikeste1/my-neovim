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
