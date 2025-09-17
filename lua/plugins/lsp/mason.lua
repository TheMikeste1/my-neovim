return {
  "mason-org/mason.nvim",
  lazy = false,
  config = function(_, opts)
    require("mason").setup(opts)
  end,
  opts = {
    registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    },
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
}
