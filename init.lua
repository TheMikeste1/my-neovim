vim.loader.enable()

local FileUtilities = require("utilities.file_utilities")

-- Set working directory
if vim.fn.argc() == 1 then
  local arg = vim.fn.argv()[1]
  -- If the argument is a non-existing directory, create it
  if arg:sub(-1) == "/" and not FileUtilities.is_directory(arg) then
    -- Create the directory
    vim.fn.mkdir(arg, "p")
  end

  if FileUtilities.is_directory(arg) then
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

require("config.env")
require("config.vim")
require("config.lazy")
require("config.theme")

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})
