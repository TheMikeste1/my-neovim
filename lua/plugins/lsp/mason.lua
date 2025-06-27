local ENSURE_INSTALLED = {
  "editorconfig-checker",
  -- Ansible
  "ansible-lint",
  -- C++
  "clangd",
  "clang-format",
  "codelldb",
  -- CMake
  "cmakelang",
  "cmakelint",
  "neocmakelsp",
  -- CSS
  "stylelint",
  -- Docker
  "hadolint",
  -- Lua
  "lua-language-server",
  "stylua",
  -- Make
  "checkmake",
  -- Python
  "black",
  "isort",
  "pyright",
  "debugpy",
  "mypy",
  "pylint",
  -- Shell/Bash
  "shellharden",
  "beautysh",
  "shellcheck",
  "bash-language-server",
  -- SQL
  "sqlfluff",
  -- Web
  "biome",
  "prettier",
  -- YAML
  "yamllint",
  "yamlfix",
  "yamlfmt",
  -- Misc
  "harper-ls",
}

return {
  "williamboman/mason.nvim",
  lazy = false,
  config = function(_, opts)
    require("mason").setup(opts)

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      if ENSURE_INSTALLED and #ENSURE_INSTALLED > 0 then
        vim.cmd("MasonInstall " .. table.concat(ENSURE_INSTALLED, " "))
      end
    end, {})
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
