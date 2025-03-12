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
  },
}
