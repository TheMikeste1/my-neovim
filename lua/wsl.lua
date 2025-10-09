if not vim.g.is_wsl then
  return
end

local original_open = vim.ui.open
vim.ui.open = function(path, opt)
  if opt ~= nil and opt.cmd == nil and path:find("^https?:") ~= nil then
    opt.cmd = { "/mnt/c/windows/explorer.exe" }
  end
  original_open(path, opt)
end
