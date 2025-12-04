if vim.g.is_wsl then
  return {
    cmd = { "godot-wsl-lsp", "--useMirroredNetworking" },
  }
end

return {}
