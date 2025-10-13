-- Make Y act like D, C, etc.
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, desc = "Yank to the end of the line" })

-- Prevent paste from overwriting the current yank buffer
vim.api.nvim_set_keymap("x", "p", "P", { noremap = true, desc = "Paste" })

-- Resize windows
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-w>+", { noremap = true, desc = "Resize window up" })
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-w>-", { noremap = true, desc = "Resize window down" })
vim.api.nvim_set_keymap("n", "<C-Left>", "<C-w><", { noremap = true, desc = "Resize window left" })
vim.api.nvim_set_keymap("n", "<C-Right>", "<C-w>>", { noremap = true, desc = "Resize window right" })
