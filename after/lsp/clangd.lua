local nproc = #vim.loop.cpu_info()
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

    -- Background indexing
    "--background-index",

    -- Completion improvements
    "--completion-style=detailed", -- More detailed completion items
    "--function-arg-placeholders=true", -- Adds placeholders for function args

    -- Better cross-reference info
    "--limit-references=0", -- Don't limit find-references (default is 1000)
    "--limit-results=0", -- Don't limit other results

    -- Preamble/PCH optimization
    "--pch-storage=memory", -- Keep precompiled headers in memory (faster)
  },
}
