vim.api.nvim_create_user_command("PurgeWindows", function(opts)
  local bufnr = 0
  local start, finish
  if opts.bang then
    start = 0
    finish = vim.api.nvim_buf_line_count(bufnr)
  else
    start = (opts.line1 or 1) - 1
    finish = opts.line2 or vim.api.nvim_buf_line_count(bufnr)
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, start, finish, false)
  for i, line in ipairs(lines) do
    lines[i] = line:gsub("\r$", "")
  end

  if opts.bang then
    -- Force the file to UNIX endings
    vim.bo.fileformat = "unix"
  end
  vim.api.nvim_buf_set_lines(bufnr, start, finish, false, lines)
  vim.notify("Converted Windows line endings to Unix style", vim.log.levels.INFO)
end, { range = true, nargs = 0, bang = true, desc = "Purge Windows newlines from the file, replacing them with Unix" })
