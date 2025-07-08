require("utilities.state")
if VSCODE then
  return
end

--- LSPs that should never be enabled directly, even if installed.
local DISABLED_LSPS = {
  "bacon_ls",
  "rust_analyzer",
}

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
