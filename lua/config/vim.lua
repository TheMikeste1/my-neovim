vim.g.mapmoveleader = " "

vim.opt.exrc = true
vim.lsp.config("*", {
  root_markers = { ".git", ".hg" },
})

vim.opt.wrap = false -- No word wrap
vim.opt.fillchars = { eob = " " } -- Don't show ~ on none-lines
vim.opt.colorcolumn = "81,121,241" -- Indicators of line length
vim.opt.scrolloff = 3 -- Always keep x rows above/below the cursor

-- Incremental highlight with no leftover highlight
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- More undos
vim.opt.undodir = (os.getenv("HOME") or os.getenv("UserProfile")) .. "/.vim/undodir"
vim.opt.undofile = true

-- Use system clipboard
if vim.fn.has("unamedplus") then
  vim.opt.clipboard = "unnamedplus"
else
  vim.opt.clipboard = "unnamed"
end

-- Set GUI colors if in the terminal
if not vim.g.vscode and vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
end

-- Use relative numbers in the gutter
vim.opt.number = true
vim.opt.relativenumber = true

-- Setup indenting
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Spelling
vim.opt.spell = not vim.g.vscode
vim.opt.spelllang = { "en_us" }

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 300 })
  end,
})

vim.opt.autoread = true
vim.opt.autowrite = true

vim.opt.signcolumn = "yes:2"
vim.opt.statuscolumn = "%=%l%s%C"

vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = 0 })]])

vim.opt.list = true
vim.opt.listchars = "tab:!·,trail:·,nbsp:+"

vim.o.timeout = false
vim.o.sessionoptions = "curdir,folds,help,tabpages,winsize,terminal,options"

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  command = "wa",
})

vim.o.virtualedit = "block"
