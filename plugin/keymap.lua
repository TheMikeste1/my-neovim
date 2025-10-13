-- Make Y act like D, C, etc.
vim.keymap.set("n", "Y", "y$", { desc = "Yank to the end of the line" })

-- Prevent paste from overwriting the current yank buffer
vim.keymap.set("x", "p", "P", { desc = "Paste" })

-- Resize windows
vim.keymap.set("n", "<C-Up>", "<C-w>+", { desc = "Resize window up" })
vim.keymap.set("n", "<C-Down>", "<C-w>-", { desc = "Resize window down" })
vim.keymap.set("n", "<C-Left>", "<C-w><", { desc = "Resize window left" })
vim.keymap.set("n", "<C-Right>", "<C-w>>", { desc = "Resize window right" })
