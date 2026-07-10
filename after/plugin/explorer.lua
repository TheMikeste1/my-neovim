local function open_explorer(opts)
  local path = opts.args

  if vim.g.is_wsl then
    vim.system({ "/mnt/c/windows/explorer.exe", path })
  else
    vim.system({ "xdg-open", path })
  end
end

vim.api.nvim_create_user_command(
  "Explorer",
  open_explorer,
  { nargs = "_", desc = "Opens a file explorer at the given path" }
)
