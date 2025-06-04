local opts = {
  filetypes = { "gd", "gdscript", "gdscript3" },
}
if IS_WSL then
  opts.cmd = { "godot-wsl-lsp", "--useMirroredNetworking" }
end

return opts
