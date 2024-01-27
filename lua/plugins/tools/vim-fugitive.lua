return {
  "tpope/vim-fugitive",
  cond = true,
  init = function()
    has_local, fugitive = pcall(require, "local.fugitive")
    if has_local then
      fugitive.init()
    end
  end,
  config = function()
    vim.api.nvim_create_user_command("Browse", function(opts)
      vim.fn.system({ "wslview", opts.fargs[1] })
    end, { nargs = 1 })
  end,
  cmd = {
    "G",
    "Git",
    "Ggrep",
    "Git",
    "Ggrep",
    "Ggrep",
    "Glgrep",
    "Gclog",
    "Gllog",
    "Gcd",
    "Glcd",
    "Gedit",
    "Gsplit",
    "Gvsplit",
    "Gtabedit",
    "Gpedit",
    "Gdrop",
    "Gread",
    "Gwrite",
    "Gwrite",
    "Gwq",
    "Gwq",
    "Gdiffsplit",
    "Gdiffsplit",
    "Gdiffsplit",
    "Gvdiffsplit",
    "Gdiffsplit",
    "Ghdiffsplit",
    "GMove",
    "GRename",
    "GDelete",
    "GRemove",
    "GUnlink",
    "GBrowse",
  },
  dependencies = {
    { "tpope/vim-rhubarb" }, -- GitHub
    { "tommcdo/vim-fubitive" }, -- Bitbucket
  },
}
