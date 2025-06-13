local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")
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

local plugin_folders = {
  { import = "plugins" },
  { import = "plugins.cmp" },
  { import = "plugins.dap" },
  { import = "plugins.languages" },
  { import = "plugins.lint" },
  { import = "plugins.lsp" },
  { import = "plugins.tools" },
  { import = "plugins.ui" },
  { import = "plugins.vim-dev" },
  { import = "themes" },
}

local options = {
  checker = {
    -- Automatically check for plugin updates
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
