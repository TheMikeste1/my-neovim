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

--- LSPs that should never be enabled directly, even if installed.
local DISABLED_LSPS = {
  "bacon_ls",
  "rust_analyzer",
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

    -- Auto-enable installed LSPs
    local lsp_names = {}
    for _, package in ipairs(require("mason-registry").get_installed_packages()) do
      if vim.tbl_contains(package.spec.categories, "LSP") then
        local name = package.spec.name
        if package.spec.neovim ~= nil and package.spec.neovim.lspconfig ~= nil then
          name = package.spec.neovim.lspconfig
        else
          name = name:gsub("%-", "_")
        end
        table.insert(lsp_names, name)
      end
    end

    vim.lsp.enable(lsp_names, true)
    vim.lsp.enable(DISABLED_LSPS, false)
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
