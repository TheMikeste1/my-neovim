-- C++ will also execute this file
vim.fn.mkdir(".cache/cppcheck", "p")

vim.keymap.set("n", "<M-o>", function()
  require("clangd_extensions.switch_source_header").switch_source_header()
end, { noremap = true, desc = "Switch between source and header" })
