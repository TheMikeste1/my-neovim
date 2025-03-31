return {
  "williamboman/mason.nvim",
  lazy = false,
  config = function(_, opts)
    require("mason").setup(opts)

    -- Custom nvchad cmd to install all mason binaries listed https://github.com/NvChad/NvChad/blob/c78f3f0501800d02b0085ecc1f79bfc64327d01e/lua/plugins/init.lua#L137
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.inspect(vim.g.mason_binaries_list)
      if opts.ensure_installed and #opts.ensure_installed > 0 then
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end
    end, {})

    vim.g.mason_binaries_list = opts.ensure_installed
  end,
  opts = {
    ensure_installed = {
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
