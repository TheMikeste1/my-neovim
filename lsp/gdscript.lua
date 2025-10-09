if vim.g.is_wsl then
  vim.lsp.config("gdscript", {
    cmd = { "godot-wsl-lsp", "--useMirroredNetworking" },
  })
end

return {}
