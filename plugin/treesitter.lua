vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})

local autoinstall_encountered = {}
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if autoinstall_encountered[lang] then
      return
    end

    autoinstall_encountered[lang] = true
    local installed = require("nvim-treesitter").get_installed()
    if vim.list_contains(installed, lang) then
      return
    end

    local available = require("nvim-treesitter").get_available()
    if vim.list_contains(available, lang) then
      require("nvim-treesitter").install(lang):await(function()
        vim.treesitter.start(args.buf, lang)
      end)
    end
  end,
})

vim.treesitter.language.register("cosmos", { "cosmos" })
