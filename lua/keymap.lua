-- Make Y act like D, C, etc.
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- Prevent paste from overwriting the current yank buffer
vim.api.nvim_set_keymap("x", "p", "P", { noremap = true })

-- Resize windows
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-w>+", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-w>-", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Left>", "<C-w><", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Right>", "<C-w>>", { noremap = true })

-- Toggle inlay hints
vim.keymap.set("n", "<leader><leader>i", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { noremap = true, desc = "Toggle inlay hints" })
