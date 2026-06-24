return {
  "mason-org/mason.nvim",
  lazy = false,
  config = function(_, opts)
    require("mason").setup(opts)
  end,
  opts = {
    PATH = "skip",
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
}
