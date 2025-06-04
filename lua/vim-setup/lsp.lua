vim.lsp.config("*", {
  root_markers = { ".git", ".hg" },
})

vim.lsp.enable({
  -- "bacon_ls",
  "bashls",
  "clangd",
  "gdscript",
  "harper_ls",
  "lemminx",
  "lua_ls",
  "pyrefly",
  "pyright",
  -- "rust_analyzer",
  "zls",
})
