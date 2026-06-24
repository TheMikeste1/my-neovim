vim.api.nvim_create_user_command("Pydoc", function(opts)
  local query = opts.args
  -- Run pydoc in the background and capture output
  local handle = io.popen("pydoc " .. query)
  if not handle then
    return
  end
  local result = handle:read("*a")
  handle:close()

  -- Split the output into lines
  local lines = {}
  for line in string.gmatch(result, "[^\r\n]+") do
    table.insert(lines, line)
  end

  vim.cmd("new")
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "man"
  vim.bo[buf].modifiable = false
end, { nargs = 1 })
