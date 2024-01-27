vim.opt.wrap = false -- No word wrap
vim.opt.fillchars = { eob = " " } -- Don't show ~ on none-lines
vim.opt.colorcolumn = "80,120,240" -- Indicators of line length
vim.opt.scrolloff = 3 -- Always keep x rows above/below the cursor

-- Incremental highlight with no leftover highlight
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- More undos
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Use system clipboard
if vim.fn.has("unamedplus") then
	vim.opt.clipboard = "unnamedplus"
else
	vim.opt.clipboard = "unnamed"
end

-- Set GUI colors if in the terminal
if not VSCODE and vim.fn.has("termguicolors") then
	vim.opt.termguicolors = true
end

-- Use relative numbers in the gutter
vim.opt.number = not VSCODE
vim.opt.relativenumber = not VSCODE

-- Setup indenting
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Spelling
vim.opt.spell = not VSCODE
vim.opt.spelllang = { "en_us" }

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})
