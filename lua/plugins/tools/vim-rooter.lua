return {
  "airblade/vim-rooter",
  cond = vim.g.vscode,
  event = "VeryLazy",
  config = function()
    vim.g.rooter_patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "*.sln" }
    local id = 0
    local function delete_cmd()
      vim.api.nvim_del_autocmd(id)
    end
    id = vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "RooterChDir",
      callback = function()
        vim.cmd("RooterToggle")
        delete_cmd()
      end,
    })
  end,
}
