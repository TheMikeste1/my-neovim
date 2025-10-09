return {
  "lucasecdb/godot-wsl-lsp",
  enabled = vim.g.is_wsl,
  -- TODO: Automatically install the LSP
  ft = {
    "gd",
    "gdscript",
    "gdscript3",
  },
}
