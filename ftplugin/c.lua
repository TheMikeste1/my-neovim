-- C++ will also execute this file
if VSCODE then
  return
end

vim.keymap.set("n", "<M-o>", function()
  require("clangd_extensions.switch_source_header").switch_source_header()
end, { noremap = true, desc = "Switch between source and header" })
