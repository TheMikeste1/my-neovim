-- Make Y act like D, C, etc.
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- Prevent paste from overwriting the current yank buffer
vim.api.nvim_set_keymap("x", "p", "P", { noremap = true })

-- Resize windows
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-w>+", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-w>-", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Left>", "<C-w><", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Right>", "<C-w>>", { noremap = true })
