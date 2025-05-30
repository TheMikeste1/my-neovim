local function handle_api_command(opts)
  vim.notify("Snacks opts: " .. vim.inspect(opts), vim.log.levels.DEBUG)
  if opts.fargs and opts.fargs[1] == "resume" then
    require("snacks").picker.resume()
    return
  end

  vim.notify("Unknown Snacks command: " .. opts.args)
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function(_, opts)
    require("snacks").setup(opts)
    vim.api.nvim_create_user_command("Snacks", handle_api_command, { desc = "Access the Snacks API", nargs = "*" })
  end,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = true,
      },
    },
    input = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
    statuscolumn = {
      left = { "mark", "sign" }, -- priority of signs on the left (high to low)
      right = { "fold", "git" }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
  },
}
