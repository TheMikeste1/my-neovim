return {
  "williamboman/mason.nvim",
  lazy = false,
  config = function(_, opts)
    require("mason").setup(opts)
  end,
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
}
