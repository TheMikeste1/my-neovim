if IS_WSL then
  vim.lsp.config("gdscript", {
    cmd = { "godot-wsl-lsp", "--useMirroredNetworking" },
  })
end

return {}
