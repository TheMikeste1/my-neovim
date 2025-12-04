local nproc = #vim.loop.cpu_info() / 2
if nproc == 0 then
  nproc = 8
end

return {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--import-insertions",
    "--malloc-trim",
    "--all-scopes-completion",
    string.format("-j=%d", nproc),
  },
}
