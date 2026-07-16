local nproc = #vim.loop.cpu_info()

return {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
    "--background-index",
    "--background-index-priority=low",
    "--clang-tidy",
    "--pch-storage=memory",
    "--malloc-trim",
    "--header-insertion=iwyu",
    "--function-arg-placeholders",
    ("-j=%d"):format(math.min(8, math.max(2, math.floor(nproc / 2)))),
  },
}
