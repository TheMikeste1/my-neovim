vim.api.nvim_create_user_command("ReverseLines", function(opts)
  local start_line = opts.line1 - 1
  local end_line = opts.line2

  if start_line >= end_line then
    -- Empty range, nothing to do
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

  if opts.bang then
    -- Reverse characters inside each line
    for i = 1, #lines do
      lines[i] = string.reverse(lines[i])
    end
  else
    -- Reverse line order
    local rev = {}
    for i = #lines, 1, -1 do
      rev[#rev + 1] = lines[i]
    end
    lines = rev
  end

  vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)
end, { range = true, nargs = 0, bang = true, desc = "Reverse selected lines" })
