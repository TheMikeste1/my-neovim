return {
  {
    "tpope/vim-fugitive",
    cond = true,
    init = function()
      vim.g.fugitive_git_executable = "LEFTHOOK_OUTPUT=failure git"
      local has_local, fugitive = pcall(require, "local.fugitive")
      if has_local then
        fugitive.init()
      end
    end,
    config = function()
      vim.api.nvim_create_user_command("Browse", function(opts)
        vim.fn.system({ "wslview", opts.fargs[1] })
      end, { nargs = 1 })
    end,
  },
  { "tpope/vim-rhubarb" }, -- GitHub
}
