require("utilities.state")

return {
  "lucasecdb/godot-wsl-lsp",
  enabled = IS_WSL,
  -- TODO: Automatically install the LSP
  ft = {
    "gd",
    "gdscript",
    "gdscript3",
  },
}
